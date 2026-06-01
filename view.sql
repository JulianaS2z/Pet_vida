1 

CREATE VIEW vw_consultas_completas AS 
SELECT 
    c.data_hora, 
    c.status AS status_consulta,
    c.diagnostico,
    a.nome AS animal,
    t.nome AS tutor,
    t.telefone AS telefone_tutor, 
    v.nome AS veterinario,
    v.especialidade,
    p.forma_pagamento,
    p.status AS status_pagamento

FROM consultas c
INNER JOIN animais a ON c.animais_id_animais = a.id_animais           
INNER JOIN especies e ON a.especies_id_especies = e.id_especies       
INNER JOIN tutores t ON a.tutores_id_tutores = t.id_tutores 
INNER JOIN veterinarios v ON c.veterinarios_id_veterinarios = v.id_veterinarios 
LEFT JOIN pagamentos p ON c.id_consultas = p.consultas_id_consultas;

2

CREATE VIEW vw_agenda_hoje AS
SELECT *
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY data_hora;

3

CREATE VIEW vw_faturamento_mensal AS
SELECT 
    YEAR(c.data_hora) AS ano,
    MONTH(c.data_hora) AS mes,
    v.nome AS veterinario,
    COUNT(c.id_consultas) AS total_consultas,
    SUM(c.valor) AS faturamento_total
FROM consultas c
INNER JOIN veterinarios v ON c.veterinarios_id_veterinarios = v.id_veterinarios
GROUP BY 
    YEAR(c.data_hora),
    MONTH(c.data_hora),
    v.id_veterinarios,
    v.nome;

4

create view vw_animais_detalhados 
as select 
	a.id_animais,
    a.nome AS animal,
    t.nome AS tutores,
    e.nome AS especies,
    count(c.id_consultas) AS total_consultas
from animais a
INNER JOIN especies e ON a.especies_id_especies = e.id_especies
INNER JOIN tutores t ON a.tutores_id_tutores = t.id_tutores
LEFT JOIN consultas c ON a.id_animais = c.animais_id_animais
GROUP BY 
	a.id_animais,
	a.nome,
	t.nome,
	e.nome;

5


CREATE VIEW vw_inadimplentes AS 
SELECT 
    animal,
    tutor,
    telefone_tutor,
    data_hora,
    status_consulta,
    status_pagamento
    
FROM vw_consultas_completas 
WHERE status_consulta = 'concluida' 
  AND (status_pagamento IS NULL OR status_pagamento = 'pago');
