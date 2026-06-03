1

DELIMITER $$
CREATE PROCEDURE sp_agendar_consulta(
    IN p_animal_id INT UNSIGNED,
    IN p_vet_id INT UNSIGNED,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    DECLARE v_animal_existe INT;
    DECLARE v_vet_existe INT;
    DECLARE v_vet_ocupado INT;
    DECLARE v_consulta_id INT UNSIGNED;

    SELECT COUNT(*) INTO v_animal_existe FROM animais WHERE id_animais = p_animal_id;
    IF v_animal_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Animal não encontrado no sistema.';
    END IF;
    
    SELECT COUNT(*) INTO v_vet_existe FROM veterinarios WHERE id_veterinarios = p_vet_id;
    IF v_vet_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Veterinário não encontrado no sistema.';
    END IF;

    SELECT COUNT(*) INTO v_vet_ocupado FROM consultas 
    WHERE veterinarios_id_veterinarios = p_vet_id AND data_hora = p_data_hora AND status != 'cancelada';
    IF v_vet_ocupado > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O veterinário já possui uma consulta agendada para este horário.';
    END IF;

    START TRANSACTION;

    INSERT INTO consultas (animais_id_animais, veterinarios_id_veterinarios, data_hora, valor, status)
    VALUES (p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');
    
    SET v_consulta_id = LAST_INSERT_ID();
    
    INSERT INTO pagamentos (consultas_id_consultas, valor_pago, forma_pagamento)
    VALUES (v_consulta_id, 0.00, 'pendente');
    
    COMMIT;
    
    SELECT 'Consulta agendada com sucesso!' AS Resultado, v_consulta_id AS ID_Consulta;
END $$
DELIMITER ;

2

DELIMITER $$
CREATE PROCEDURE sp_concluir_consulta(
    IN p_consulta_id INT UNSIGNED,
    IN p_diagnostico VARCHAR(45)
)
BEGIN
    DECLARE v_consulta_existe INT;

    SELECT COUNT(*) INTO v_consulta_existe FROM consultas WHERE id_consultas = p_consulta_id;
    IF v_consulta_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Consulta não encontrada.';
    END IF;

    UPDATE consultas
    SET status = 'concluida', diagnostico = p_diagnostico
    WHERE id_consultas = p_consulta_id;
    
    SELECT 'Consulta concluída com sucesso!' AS Resultado;
END $$
DELIMITER ;

3

DELIMITER $$
CREATE PROCEDURE sp_concluir_consulta(
    IN p_consulta_id INT UNSIGNED,
    IN p_diagnostico VARCHAR(45)
)
BEGIN
    DECLARE v_consulta_existe INT;

    SELECT COUNT(*) INTO v_consulta_existe FROM consultas WHERE id_consultas = p_consulta_id;
    IF v_consulta_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Consulta não encontrada.';
    END IF;

    UPDATE consultas
    SET status = 'concluida', diagnostico = p_diagnostico
    WHERE id_consultas = p_consulta_id;
    
    SELECT 'Consulta concluída com sucesso!' AS Resultado;
END $$
DELIMITER ;

4

DELIMITER $$
CREATE PROCEDURE sp_cancelar_consulta(
    IN p_consulta_id INT UNSIGNED
)
BEGIN
    DECLARE v_consulta_existe INT;

    SELECT COUNT(*) INTO v_consulta_existe FROM consultas WHERE id_consultas = p_consulta_id;
    IF v_consulta_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Consulta não encontrada.';
    END IF;

    START TRANSACTION;
    
    UPDATE consultas
    SET status = 'cancelada'
    WHERE id_consultas = p_consulta_id;

    UPDATE pagamentos
    SET forma_pagamento = 'cancelado'
    WHERE consultas_id_consultas = p_consulta_id;
    
    COMMIT;
    
    SELECT 'Consulta e pagamento cancelados com sucesso!' AS Resultado;
END $$
DELIMITER ;

5

DELIMITER $$
CREATE PROCEDURE sp_cadastrar_animal(
    IN p_nome VARCHAR(50),
    IN p_especie_id INT UNSIGNED,
    IN p_raca VARCHAR(30),
    IN p_nascimento DATE,
    IN p_tutor_id INT UNSIGNED
)
BEGIN
    DECLARE v_especie_existe INT;
    DECLARE v_tutor_existe INT;
    DECLARE v_novo_id INT UNSIGNED;

    SELECT COUNT(*) INTO v_especie_existe FROM especies WHERE id_especies = p_especie_id;
    IF v_especie_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Espécie não cadastrada no sistema.';
    END IF;

    SELECT COUNT(*) INTO v_tutor_existe FROM tutores WHERE id_tutores = p_tutor_id;
    IF v_tutor_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Tutor não cadastrado no sistema.';
    END IF;

    INSERT INTO animais (nome, especies_id_especies, raca, data_nascimento, tutores_id_tutores)
    VALUES (p_nome, p_especie_id, p_raca, p_nascimento, p_tutor_id);

    SET v_novo_id = LAST_INSERT_ID();
    
    SELECT 'Animal cadastrado com sucesso!' AS Resultado, v_novo_id AS ID_Novo_Animal;
END $$
DELIMITER ;