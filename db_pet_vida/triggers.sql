-- 1

CREATE TABLE IF NOT EXISTS `log_auditoria` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tabela_afetada` VARCHAR(50) NOT NULL,
  `acao` VARCHAR(20) NOT NULL,
  `registro_id` INT UNSIGNED NOT NULL,
  `detalhes` TEXT NULL,
  `data_hora` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

DELIMITER $$

-- 2 a)

CREATE TRIGGER `trg_after_insert_consulta`
AFTER INSERT ON `consultas`
FOR EACH ROW
BEGIN
    INSERT INTO `log_auditoria` (`tabela_afetada`, `acao`, `registro_id`, `detalhes`)
    VALUES (
        'consultas', 
        'INSERT', 
        NEW.id_consultas, 
        CONCAT('Nova consulta agendada para o animal ID: ', NEW.animais_id_animais, ' no valor de R$ ', NEW.valor)
    );

DELIMITER ;


--  b)

DELIMITER $$

CREATE TRIGGER `trg_after_update_consulta_status`
AFTER UPDATE ON `consultas`
FOR EACH ROW
BEGIN
    -- Dispara apenas se o status realmente mudou
    IF OLD.status <> NEW.status THEN
        INSERT INTO `log_auditoria` (`tabela_afetada`, `acao`, `registro_id`, `detalhes`)
        VALUES (
            'consultas', 
            'UPDATE_STATUS', 
            NEW.id_consultas, 
            CONCAT('Alteração de status de "', OLD.status, '" para "', NEW.status, '"')
        );
    END IF;

DELIMITER ;


-- c) 
DELIMITER $$

CREATE TRIGGER `trg_before_delete_consulta`
BEFORE DELETE ON `consultas`
FOR EACH ROW
BEGIN
    -- Verifica se existe algum pagamento com status 'pago' para esta consulta
    IF EXISTS (SELECT 1 FROM `pagamentos` WHERE `consultas_id_consultas` = OLD.id_consultas AND `status` = 'pago') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Não é permitido excluir uma consulta que já foi paga!';
    END IF;

DELIMITER ;


-- d)
DELIMITER $$

CREATE TRIGGER `trg_after_insert_animal`
AFTER INSERT ON `animais`
FOR EACH ROW
BEGIN
    INSERT INTO `log_auditoria` (`tabela_afetada`, `acao`, `registro_id`, `detalhes`)
    VALUES (
        'animais', 
        'INSERT', 
        NEW.id_animais, 
        CONCAT('Animal "', NEW.nome, '" cadastrado para o tutor ID: ', NEW.tutores_id_tutores)
    );

DELIMITER ;


-- e)
DELIMITER $$

CREATE TRIGGER `trg_before_update_pagamento`
BEFORE UPDATE ON `pagamentos`
FOR EACH ROW
BEGIN
    -- Se o status está mudando para 'pago', preenche automaticamente com a data e hora atuais
    IF NEW.status = 'pago' AND OLD.status <> 'pago' THEN
        SET NEW.data_pagamento = NOW();
    END IF;
END$$


DELIMITER ;

