1
USE `db_pet_vida`;

DROP FUNCTION IF EXISTS fn_idade_animal;
DELIMITER $$
CREATE FUNCTION fn_idade_animal(data_nascimento DATE) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE anos INT;
    DECLARE meses INT;
    DECLARE resultado VARCHAR(50);
    
    IF data_nascimento IS NULL THEN
        RETURN 'Data não informada';
    END IF;
    
    SET anos = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
  
    SET meses = TIMESTAMPDIFF(MONTH, data_nascimento, CURDATE()) % 12;
    
    SET resultado = CONCAT(anos, ' ano(s) e ', meses, ' mes(es)');    
    RETURN resultado;
END$$
DELIMITER ;

SELECT 
    a.id_animais AS 'ID',
    a.nome AS 'Nome do Pet',
    e.nome AS 'Espécie',
    a.raca AS 'Raça',
    DATE_FORMAT(a.data_nascimento, '%d/%m/%Y') AS 'Nascimento',
    fn_idade_animal(a.data_nascimento) AS 'Idade Atual'
FROM animais a
INNER JOIN especies e ON a.especies_id_especies = e.id_especies;

2

DROP FUNCTION IF EXISTS fn_total_gasto_tutor;
DELIMITER $$
CREATE FUNCTION fn_total_gasto_tutor(tutor_id INT UNSIGNED) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2) DEFAULT 0.00;
    
    SELECT IFNULL(SUM(c.valor), 0.00) INTO total
    FROM `consultas` c
    JOIN `animais` a ON c.animais_id_animais = a.id_animais
    WHERE a.tutores_id_tutores = tutor_id 
      AND c.status <> 'cancelada';
      
    RETURN total;
END$$
DELIMITER ;

SELECT 
    id_tutores AS 'ID',
    nome AS 'Tutor',
    cpf AS 'CPF',
    CONCAT('R$ ', REPLACE(REPLACE(REPLACE(FORMAT(fn_total_gasto_tutor(id_tutores), 2), '.', '|'), ',', '.'), '|', ',')) AS 'Total Gasto'
FROM tutores
ORDER BY fn_total_gasto_tutor(id_tutores) DESC;

3

DROP FUNCTION IF EXISTS fn_qtd_consultas_animal;
DELIMITER $$
CREATE FUNCTION fn_qtd_consultas_animal(animal_id INT UNSIGNED) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_consultas INT DEFAULT 0;
    
    SELECT COUNT(*) INTO total_consultas
    FROM `consultas`
    WHERE animais_id_animais = animal_id;
    
    RETURN total_consultas;
END$$
DELIMITER ;

USE `db_pet_vida`;

SELECT 
    a.id_animais AS 'ID',
    a.nome AS 'Nome do Pet',
    e.nome AS 'Espécie',
    fn_qtd_consultas_animal(a.id_animais) AS 'Total de Consultas'
FROM animais a
INNER JOIN especies e ON a.especies_id_especies = e.id_especies
ORDER BY `Total de Consultas` DESC;

4

DROP FUNCTION IF EXISTS fn_status_emoji;
DELIMITER $$
CREATE FUNCTION fn_status_emoji(status_consulta VARCHAR(20)) 
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
    DECLARE status_formatado VARCHAR(40);
    
    SET status_formatado = CASE status_consulta
        WHEN 'agendada' THEN '📅 Agendada'
        WHEN 'concluida' THEN '✅ Concluída'
        WHEN 'cancelada' THEN '❌ Cancelada'
        WHEN 'em_atendimento' THEN '🏥 Em Atendimento'
        ELSE '⚠️ Desconhecido'
    END;
    
    RETURN status_formatado;
END$$
DELIMITER ;

SELECT 
    c.id_consultas AS 'Nº',
    a.nome AS 'Paciente',
    v.nome AS 'Veterinário',
    DATE_FORMAT(c.data_hora, '%d/%m/%Y %H:%i') AS 'Data/Hora',
    fn_status_emoji(c.status) AS 'Status Atual'
FROM consultas c
INNER JOIN animais a ON c.animais_id_animais = a.id_animais
INNER JOIN veterinarios v ON c.veterinarios_id_veterinarios = v.id_veterinarios
ORDER BY c.data_hora DESC;

5

DROP FUNCTION IF EXISTS fn_classificar_valor;
DELIMITER $$
CREATE FUNCTION fn_classificar_valor(valor_consulta DECIMAL(10,2)) 
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE classificacao VARCHAR(30);
    
    IF valor_consulta < 100.00 THEN
        SET classificacao = 'Consulta Simples';
    ELSEIF valor_consulta >= 100.00 AND valor_consulta <= 300.00 THEN
        SET classificacao = 'Consulta Padrão';
    ELSE
        SET classificacao = 'Procedimento Especial';
    END IF;
    
    RETURN classificacao;
END$$
DELIMITER ;

SELECT 
    c.id_consultas AS 'Nº',
    a.nome AS 'Paciente',
    c.diagnostico AS 'Procedimento',
    CONCAT('R$ ', c.valor) AS 'Valor',
    fn_classificar_valor(c.valor) AS 'Classificação'
FROM consultas c
INNER JOIN animais a ON c.animais_id_animais = a.id_animais
ORDER BY c.valor DESC;

