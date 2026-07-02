const state = {
  apiBaseUrl: localStorage.getItem('petVidaApiBaseUrl') || 'http://localhost:3000/api',
};

const elements = {
  apiConfigForm: document.querySelector('#apiConfigForm'),
  apiBaseUrl: document.querySelector('#apiBaseUrl'),
  statusPanel: document.querySelector('#statusPanel'),
  statusText: document.querySelector('#statusText'),
  reloadButton: document.querySelector('#reloadButton'),
  tutoresList: document.querySelector('#tutoresList'),
  animaisList: document.querySelector('#animaisList'),
  tutoresCount: document.querySelector('#tutoresCount'),
  animaisCount: document.querySelector('#animaisCount'),
  tutorForm: document.querySelector('#tutorForm'),
  animalForm: document.querySelector('#animalForm'),
  consultaForm: document.querySelector('#consultaForm'),
};

elements.apiBaseUrl.value = state.apiBaseUrl;

function setStatus(message, type = 'info') {
  elements.statusPanel.classList.remove('success', 'error');

  if (type === 'success' || type === 'error') {
    elements.statusPanel.classList.add(type);
  }

  elements.statusText.textContent = message;
}

function getFormData(form) {
  return Object.fromEntries(
    Array.from(new FormData(form).entries())
      .map(([key, value]) => [key, typeof value === 'string' ? value.trim() : value])
      .filter(([, value]) => value !== '')
  );
}

function normalizeApiData(payload) {
  if (Array.isArray(payload)) {
    return payload;
  }

  if (Array.isArray(payload?.data)) {
    return payload.data;
  }

  return [];
}

async function apiRequest(path, options = {}) {
  const url = `${state.apiBaseUrl.replace(/\/$/, '')}${path}`;
  const response = await fetch(url, {
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {}),
    },
    ...options,
  });

  const contentType = response.headers.get('content-type') || '';
  const payload = contentType.includes('application/json')
    ? await response.json()
    : { message: await response.text() };

  if (!response.ok || payload.success === false) {
    throw new Error(payload.message || payload.error || `Erro HTTP ${response.status}`);
  }

  return payload;
}

function createDetails(fields) {
  const dl = document.createElement('dl');

  fields.forEach(([label, value]) => {
    if (value === undefined || value === null || value === '') {
      return;
    }

    const wrapper = document.createElement('div');
    const dt = document.createElement('dt');
    const dd = document.createElement('dd');

    dt.textContent = label;
    dd.textContent = value;
    wrapper.append(dt, dd);
    dl.appendChild(wrapper);
  });

  return dl;
}

function renderList(container, countElement, items, renderItem, emptyMessage) {
  container.innerHTML = '';
  countElement.textContent = items.length;

  if (!items.length) {
    const empty = document.createElement('p');
    empty.className = 'empty-state';
    empty.textContent = emptyMessage;
    container.appendChild(empty);
    return;
  }

  items.forEach((item) => container.appendChild(renderItem(item)));
}

function renderTutor(tutor) {
  const card = document.createElement('article');
  card.className = 'item';

  const title = document.createElement('strong');
  title.textContent = tutor.nome || 'Tutor sem nome';

  card.append(
    title,
    createDetails([
      ['ID', tutor.id_tutores],
      ['CPF', tutor.cpf],
      ['Email', tutor.email],
      ['Telefone', tutor.telefone],
    ])
  );

  return card;
}

function renderAnimal(animal) {
  const card = document.createElement('article');
  card.className = 'item';

  const title = document.createElement('strong');
  title.textContent = animal.animal || animal.nome || 'Animal sem nome';

  card.append(
    title,
    createDetails([
      ['ID', animal.id_animais],
      ['Tutor', animal.tutores || animal.tutor],
      ['Especie', animal.especies || animal.especie],
      ['Consultas', animal.total_consultas],
    ])
  );

  return card;
}

async function loadLists() {
  setStatus('Carregando tutores e animais...');
  elements.reloadButton.disabled = true;

  try {
    const [tutoresPayload, animaisPayload] = await Promise.all([
      apiRequest('/tutores'),
      apiRequest('/animais'),
    ]);

    const tutores = normalizeApiData(tutoresPayload);
    const animais = normalizeApiData(animaisPayload);

    renderList(elements.tutoresList, elements.tutoresCount, tutores, renderTutor, 'Nenhum tutor encontrado.');
    renderList(elements.animaisList, elements.animaisCount, animais, renderAnimal, 'Nenhum animal encontrado.');
    setStatus('Listas atualizadas com sucesso.', 'success');
  } catch (error) {
    setStatus(`Nao foi possivel carregar as listas: ${error.message}`, 'error');
  } finally {
    elements.reloadButton.disabled = false;
  }
}

async function submitJsonForm(form, path, transformPayload, successMessage) {
  const submitButton = form.querySelector('button[type="submit"]');
  const payload = transformPayload(getFormData(form));

  submitButton.disabled = true;
  setStatus('Enviando dados para a API...');

  try {
    const result = await apiRequest(path, {
      method: 'POST',
      body: JSON.stringify(payload),
    });

    form.reset();
    setStatus(result.message || successMessage, 'success');
    await loadLists();
  } catch (error) {
    setStatus(`Erro ao enviar: ${error.message}`, 'error');
  } finally {
    submitButton.disabled = false;
  }
}

elements.apiConfigForm.addEventListener('submit', (event) => {
  event.preventDefault();
  state.apiBaseUrl = elements.apiBaseUrl.value.trim();
  localStorage.setItem('petVidaApiBaseUrl', state.apiBaseUrl);
  setStatus('URL da API atualizada.', 'success');
  loadLists();
});

elements.reloadButton.addEventListener('click', loadLists);

elements.tutorForm.addEventListener('submit', (event) => {
  event.preventDefault();
  submitJsonForm(
    elements.tutorForm,
    '/tutores',
    (payload) => payload,
    'Tutor cadastrado com sucesso.'
  );
});

elements.animalForm.addEventListener('submit', (event) => {
  event.preventDefault();
  submitJsonForm(
    elements.animalForm,
    '/animais',
    (payload) => ({
      ...payload,
      especie_id: Number(payload.especie_id),
      tutor_id: Number(payload.tutor_id),
    }),
    'Animal cadastrado com sucesso.'
  );
});

elements.consultaForm.addEventListener('submit', (event) => {
  event.preventDefault();
  submitJsonForm(
    elements.consultaForm,
    '/consultas',
    (payload) => ({
      animal_id: Number(payload.animal_id),
      veterinario_id: Number(payload.veterinario_id),
      data_hora: payload.data_hora,
      valor: Number(payload.valor),
    }),
    'Consulta agendada com sucesso.'
  );
});

loadLists();
