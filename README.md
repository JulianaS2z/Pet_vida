# Clínica Pet Vida

Aplicação de gerenciamento de clínica veterinária desenvolvida em Node.js com MySQL.

## Estrutura do banco

- Tutores
- Animais
- Espécies
- Veterinários
- Consultas
- Pagamentos

## Funcionalidades

- Cadastro de tutores
- Cadastro de animais
- Controle de consultas
- Controle financeiro
- Relacionamentos com Foreign Keys
- Normalização utilizando tabela de espécies

## Tecnologias

- Node.js
- Express
- MySQL
- MySQL Workbench
- Git
- GitHub

## Como executar

### Configuração do Banco de Dados

1. Execute o arquivo `db_pet_vida/schema.sql` para criar a estrutura
2. Execute o arquivo `db_pet_vida/view.sql` para criar as views
3. Execute o arquivo `db_pet_vida/procedure.sql` para criar as stored procedures
4. Execute o arquivo `db_pet_vida/seed.sql` para popular dados de exemplo

### Configuração da Aplicação

1. Instale as dependências:
```bash
npm install
```

2. Crie um arquivo `.env` baseado em `.env.example`:
```bash
cp .env.example .env
```

3. Configure as variáveis de ambiente no arquivo `.env`

4. Inicie o servidor:
```bash
npm start
```

O servidor iniciará na porta 3000 (ou a porta definida na variável `PORT`)

## API Endpoints

### Veterinários
- `GET /api/veterinarios` — lista todos os veterinários
- `GET /api/veterinarios/:id` — obtém um veterinário específico

### Animais
- `GET /api/animais` — lista todos os animais com detalhes
- `GET /api/animais/:id` — obtém um animal específico

### Espécies
- `GET /api/especies` — lista todas as espécies
- `GET /api/especies/:id` — obtém uma espécie específica

### Tutores
- `GET /api/tutores` — lista todos os tutores
- `GET /api/tutores/:id` — obtém um tutor específico

### Consultas
- `GET /api/consultas/agenda/:data` — lista consultas de uma data específica (formato: YYYY-MM-DD)
- `GET /api/consultas/:id` — obtém uma consulta específica
- `POST /api/consultas` — agenda uma nova consulta
  - Body: `{ animal_id, veterinario_id, data_hora, valor }`
- `PUT /api/consultas/:id/concluir` — conclui uma consulta
  - Body: `{ diagnostico }`

### Pagamentos
- `GET /api/pagamentos/:id` — obtém um pagamento específico
- `POST /api/pagamentos/:consulta_id` — registra um pagamento
  - Body: `{ valor_pago, forma_pagamento }` (forma_pagamento: pix, cartao, dinheiro, convênio)

### Relatórios
- `GET /api/relatorios/dashboard` — dashboard financeiro com resumo de consultas e faturamento
- `GET /api/relatorios/inadimplentes` — lista de clientes inadimplentes

## Estrutura do Projeto

```
Pet_vida/
├── db_pet_vida/
│   ├── schema.sql          # Estrutura do banco de dados
│   ├── view.sql            # Views do banco de dados
│   ├── procedure.sql       # Stored procedures
│   ├── seed.sql            # Dados de exemplo
│   ├── triggers.sql        # Triggers do banco de dados
│   └── functions.sql       # Funções do banco de dados
├── src/
│   ├── config/
│   │   └── database.js     # Configuração da conexão MySQL
│   └── routes/
│       ├── app.js          # Configuração principal das rotas
│       ├── veterinarios.js # Rotas de veterinários
│       ├── animais.js      # Rotas de animais
│       ├── consultas.js    # Rotas de consultas
│       ├── especies.js     # Rotas de espécies
│       ├── tutores.js      # Rotas de tutores
│       ├── pagamentos.js   # Rotas de pagamentos
│       └── relatorios.js   # Rotas de relatórios
├── server.js               # Arquivo principal do servidor
├── package.json            # Dependências do projeto
├── .env.example            # Exemplo de variáveis de ambiente
└── README.md               # Este arquivo
```

## Respostas da API

Todas as respostas seguem o padrão:

```json
{
  "success": true/false,
  "data": {},
  "message": "Mensagem descritiva"
}
```

## Tratamento de Erros

- `400` — Requisição inválida (parâmetros faltando)
- `404` — Recurso não encontrado
- `500` — Erro interno do servidor