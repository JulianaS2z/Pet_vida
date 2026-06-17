-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: db_pet_vida
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `db_pet_vida`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_pet_vida` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_pet_vida`;

--
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animais` (
  `id_animais` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `especies_id_especies` int unsigned NOT NULL,
  `raca` varchar(30) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tutores_id_tutores` int unsigned NOT NULL,
  PRIMARY KEY (`id_animais`),
  KEY `fk_animais_tutores1_idx` (`tutores_id_tutores`),
  KEY `fk_animais_especies1_idx` (`especies_id_especies`),
  KEY `tutor_id` (`tutores_id_tutores`),
  CONSTRAINT `fk_animais_especies1` FOREIGN KEY (`especies_id_especies`) REFERENCES `especies` (`id_especies`),
  CONSTRAINT `fk_animais_tutores1` FOREIGN KEY (`tutores_id_tutores`) REFERENCES `tutores` (`id_tutores`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
INSERT INTO `animais` VALUES (1,'Flok',1,'Poodle','2022-07-14',4),(2,'Channy',2,'Persa','2023-01-20',5),(3,'Pipoco',1,'Golden Retriever','2021-11-05',6),(4,'Fred',1,'Beagle','2020-04-12',7),(5,'Mia',2,'Angorá','2022-09-18',1),(6,'Bob',1,'Pastor Alemão','2019-11-30',2),(7,'Bela',1,'Shih Tzu','2021-06-25',3),(8,'Zeus',1,'Rottweiler','2018-03-14',4),(9,'Nina',1,'Vira-lata','2023-02-10',1),(10,'Luke',1,'Bulldog Frances','2022-05-22',3),(11,'Amora',2,'Maine Coon','2021-08-05',5),(12,'Pipoca',1,'Pug','2023-11-12',6),(13,'Cacau',1,'Cocker Spaniel','2020-01-28',7),(14,'Simba',2,'Persa','2022-03-03',8),(15,'Maya',1,'Border Collie','2021-10-15',1),(16,'Fubá',1,'Vira-lata','2026-05-10',1),(17,'Thor',1,'Labrador','2023-05-10',1),(20,'Thor de Teste',1,'Bulldog','2025-01-01',1);
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_animal` AFTER INSERT ON `animais` FOR EACH ROW BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES (
        'animais', 
        'INSERT', 
        NEW.id_animais, 
        CONCAT('Animal "', NEW.nome, '" cadastrado (Raça: ', NEW.raca, ', Tutor ID: ', NEW.tutores_id_tutores, ')')
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `id_consultas` int unsigned NOT NULL AUTO_INCREMENT,
  `animais_id_animais` int unsigned NOT NULL,
  `veterinarios_id_veterinarios` int unsigned NOT NULL,
  `data_hora` datetime NOT NULL,
  `diagnostico` varchar(45) DEFAULT NULL,
  `valor` decimal(10,2) unsigned NOT NULL,
  `status` enum('agendada','em_atendimento','concluida','cancelada') NOT NULL,
  PRIMARY KEY (`id_consultas`),
  KEY `fk_consultas_animais_idx` (`animais_id_animais`),
  KEY `fk_consultas_veterinarios1_idx` (`veterinarios_id_veterinarios`),
  KEY `data_hora` (`data_hora`),
  CONSTRAINT `fk_consultas_animais` FOREIGN KEY (`animais_id_animais`) REFERENCES `animais` (`id_animais`),
  CONSTRAINT `fk_consultas_veterinarios1` FOREIGN KEY (`veterinarios_id_veterinarios`) REFERENCES `veterinarios` (`id_veterinarios`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2025-05-10 14:00:00','Paciente recuperado.',150.00,'cancelada'),(2,2,2,'2025-05-11 09:30:00','Check-up de rotina',120.00,'em_atendimento'),(3,3,3,'2025-05-11 11:00:00','Tratamento de otite',180.00,'agendada'),(4,4,1,'2025-05-12 15:15:00','Exame de sangue',200.00,'concluida'),(5,5,2,'2025-05-13 16:00:00','Limpeza de tártaro',350.00,'cancelada'),(6,6,3,'2025-05-14 10:00:00','Consulta dermatológica',160.00,'concluida'),(7,7,1,'2025-05-14 14:30:00','Aplicação de antipulgas',90.00,'em_atendimento'),(8,8,2,'2025-05-15 08:00:00','Castração preventiva',450.00,'agendada'),(9,9,3,'2025-05-15 13:00:00','Tratamento de gastrite',220.00,'concluida'),(10,10,1,'2025-05-16 11:30:00','Retirada de pontos',80.00,'cancelada'),(11,11,2,'2025-05-16 16:45:00','Vacinação Antirrábica',150.00,'em_atendimento'),(12,12,3,'2025-05-17 09:00:00','Exame de ultrassom',250.00,'concluida'),(13,13,1,'2025-05-17 10:30:00','Avaliação cirúrgica',180.00,'agendada'),(14,14,2,'2025-05-18 14:00:00','Curativo em pata',95.00,'concluida'),(15,15,3,'2025-05-18 15:30:00','Tratamento de sarna',190.00,'cancelada'),(16,1,1,'2025-05-19 11:00:00','Consulta oftálmica',170.00,'concluida'),(17,2,2,'2025-05-19 16:00:00','Desparasitação interna',75.00,'agendada'),(18,3,3,'2025-05-20 09:15:00','Corte de unhas e higiene',60.00,'concluida'),(19,4,1,'2025-05-20 13:45:00','Remoção de corpo estranho',310.00,'em_atendimento'),(20,15,2,'2025-05-21 10:00:00','Check-up geriátrico',210.00,'agendada'),(21,1,1,'2026-05-31 21:14:18','Consulta de rotina para teste',150.00,'agendada'),(22,1,2,'2026-06-15 10:00:00',NULL,150.00,'agendada'),(23,1,1,'2026-12-20 14:00:00',NULL,150.00,'agendada'),(99,1,1,'2026-06-15 10:00:00','Consulta de Teste',100.00,'concluida'),(999,1,1,'2026-06-15 10:00:00','Consulta de Teste',100.00,'concluida'),(1000,1,2,'2026-12-11 01:00:00',NULL,20.00,'agendada');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_consulta` AFTER INSERT ON `consultas` FOR EACH ROW BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES (
        'consultas', 
        'INSERT', 
        NEW.id_consultas, 
        CONCAT('Nova consulta agendada para o animal ID ', NEW.animais_id_animais, ' com o status: ', NEW.status)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_update_consulta_status` AFTER UPDATE ON `consultas` FOR EACH ROW BEGIN
    -- Dispara apenas se o status da consulta foi modificado
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
        VALUES (
            'consultas', 
            'UPDATE', 
            NEW.id_consultas, 
            CONCAT('Status alterado de "', OLD.status, '" para "', NEW.status, '"')
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_delete_consulta` BEFORE DELETE ON `consultas` FOR EACH ROW BEGIN
    -- Declara variável para checar o status do pagamento
    DECLARE v_status_pagamento VARCHAR(20);
    
    -- Busca o status do pagamento vinculado a essa consulta
    SELECT status INTO v_status_pagamento 
    FROM pagamentos 
    WHERE consultas_id_consultas = OLD.id_consultas 
    LIMIT 1;
    
    -- Se estiver pago, cancela a operação disparando um erro customizado (SQLSTATE 45000)
    IF v_status_pagamento = 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRO: Não é permitido excluir uma consulta cujo pagamento já foi realizado.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `especies`
--

DROP TABLE IF EXISTS `especies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especies` (
  `id_especies` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id_especies`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especies`
--

LOCK TABLES `especies` WRITE;
/*!40000 ALTER TABLE `especies` DISABLE KEYS */;
INSERT INTO `especies` VALUES (3,'Ave'),(1,'Cachorro'),(2,'Gato'),(4,'Peixe'),(5,'Réptil');
/*!40000 ALTER TABLE `especies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_auditoria`
--

DROP TABLE IF EXISTS `log_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tabela_afetada` varchar(50) NOT NULL,
  `acao` varchar(20) NOT NULL,
  `registro_id` int NOT NULL,
  `detalhes` text,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_auditoria`
--

LOCK TABLES `log_auditoria` WRITE;
/*!40000 ALTER TABLE `log_auditoria` DISABLE KEYS */;
INSERT INTO `log_auditoria` VALUES (1,'consultas','INSERT',999,'Nova consulta agendada para o animal ID 1 com o status: agendada','2026-06-15 00:13:06'),(2,'consultas','UPDATE',999,'Status alterado de \"agendada\" para \"concluida\"','2026-06-15 00:13:48'),(3,'animais','INSERT',20,'Animal \"Thor de Teste\" cadastrado (Raça: Bulldog, Tutor ID: 1)','2026-06-15 00:26:12'),(4,'consultas','INSERT',1000,'Nova consulta agendada para o animal ID 1 com o status: agendada','2026-06-16 01:32:07');
/*!40000 ALTER TABLE `log_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `id_pagamentos` int unsigned NOT NULL AUTO_INCREMENT,
  `consultas_id_consultas` int unsigned NOT NULL,
  `valor_pago` decimal(10,2) unsigned NOT NULL,
  `forma_pagamento` enum('pix','cartao','dinheiro','convênio') NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `status` enum('pago','pendente','cancelado') NOT NULL,
  PRIMARY KEY (`id_pagamentos`),
  KEY `fk_pagamentos_consultas1_idx` (`consultas_id_consultas`),
  CONSTRAINT `fk_pagamentos_consultas1` FOREIGN KEY (`consultas_id_consultas`) REFERENCES `consultas` (`id_consultas`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,1,150.00,'pix','2025-05-10 15:00:00','cancelado'),(2,2,120.00,'cartao','2025-05-11 10:15:00','pago'),(3,3,180.00,'dinheiro','2026-06-14 00:00:00','pago'),(4,4,200.00,'pix','2025-05-12 15:45:00','pago'),(5,5,350.00,'convênio','2025-05-13 16:30:00','cancelado'),(6,6,160.00,'dinheiro','2025-05-14 10:45:00','pago'),(7,7,90.00,'pix','2025-05-14 15:00:00','pago'),(8,8,450.00,'cartao','2025-05-15 09:30:00','pendente'),(9,9,220.00,'cartao','2025-05-15 13:45:00','pago'),(10,10,80.00,'dinheiro','2025-05-16 12:00:00','pago'),(11,11,150.00,'pix','2026-06-14 00:00:00','pago'),(12,12,250.00,'convênio','2025-05-17 09:50:00','pago'),(13,13,180.00,'cartao','2025-05-17 11:10:00','pago'),(14,14,95.00,'pix','2025-05-18 14:20:00','pago'),(15,15,190.00,'convênio','2025-05-18 16:00:00','cancelado'),(16,16,170.00,'dinheiro','2025-05-19 11:40:00','pago'),(17,17,75.00,'pix','2025-05-19 16:15:00','pendente'),(18,18,60.00,'cartao','2025-05-20 09:45:00','pago'),(19,19,310.00,'cartao','2025-05-20 14:30:00','pago'),(20,20,210.00,'pix','2025-05-21 10:45:00','pago'),(21,22,0.00,'dinheiro','2026-06-15 10:00:00','pendente'),(22,23,0.00,'dinheiro','2026-06-03 22:13:53','pendente'),(23,1000,0.00,'dinheiro','2026-06-15 22:32:07','pendente');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_pagamento` BEFORE UPDATE ON `pagamentos` FOR EACH ROW BEGIN
    -- Se o status antigo não era 'pago' e o novo status está mudando para 'pago'
    IF (OLD.status IS NULL OR OLD.status <> 'pago') AND NEW.status = 'pago' THEN
        SET NEW.data_pagamento = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tutores`
--

DROP TABLE IF EXISTS `tutores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutores` (
  `id_tutores` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_tutores`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutores`
--

LOCK TABLES `tutores` WRITE;
/*!40000 ALTER TABLE `tutores` DISABLE KEYS */;
INSERT INTO `tutores` VALUES (1,'Kaique Aquino','521.843.901-44','kai@gmail.com','71981249033'),(2,'joel Macena','364.715.028-91','mace@gmail.com','71974351280'),(3,'Alexande Santos','892.431.765-07','alex@gmail.com','71962058471'),(4,'Nilton Santana','159.284.637-55','satan@gmail.com','71993175842'),(5,'Lucas Pereira','987.654.321-00','lucas@gmail.com','71912345678'),(6,'Beatriz Gomes','456.789.123-11','beatriz@gmail.com','71954321678'),(7,'Rodrigo Martins','789.123.456-22','rodrigo@gmail.com','71967854321'),(8,'Mariana Rocha','321.654.987-33','mariana@gmail.com','71934567812');
/*!40000 ALTER TABLE `tutores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinarios`
--

DROP TABLE IF EXISTS `veterinarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinarios` (
  `id_veterinarios` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `crmv` varchar(20) NOT NULL,
  `especialidade` varchar(45) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_veterinarios`),
  UNIQUE KEY `crmv_UNIQUE` (`crmv`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinarios`
--

LOCK TABLES `veterinarios` WRITE;
/*!40000 ALTER TABLE `veterinarios` DISABLE KEYS */;
INSERT INTO `veterinarios` VALUES (1,'Juliana dos Santos','CRMV001','Clínico Geral','(71)94002-8922'),(2,'Maria Almeida','CRMV002','Cardiologia','(71)92424-9595'),(3,'Nilson Fernado','CRMV003','Dermatologia','(71)93131-2525');
/*!40000 ALTER TABLE `veterinarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agenda_hoje`
--

DROP TABLE IF EXISTS `vw_agenda_hoje`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agenda_hoje` AS SELECT 
 1 AS `data_hora`,
 1 AS `status_consulta`,
 1 AS `diagnostico`,
 1 AS `animal`,
 1 AS `tutor`,
 1 AS `telefone_tutor`,
 1 AS `veterinario`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_animais_detalhados`
--

DROP TABLE IF EXISTS `vw_animais_detalhados`;
/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_animais_detalhados` AS SELECT 
 1 AS `id_animais`,
 1 AS `animal`,
 1 AS `tutores`,
 1 AS `especies`,
 1 AS `total_consultas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_consultas_completas`
--

DROP TABLE IF EXISTS `vw_consultas_completas`;
/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_consultas_completas` AS SELECT 
 1 AS `data_hora`,
 1 AS `status_consulta`,
 1 AS `diagnostico`,
 1 AS `animal`,
 1 AS `tutor`,
 1 AS `telefone_tutor`,
 1 AS `veterinario`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento_mensal`
--

DROP TABLE IF EXISTS `vw_faturamento_mensal`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento_mensal` AS SELECT 
 1 AS `ano`,
 1 AS `mes`,
 1 AS `veterinario`,
 1 AS `total_consultas`,
 1 AS `faturamento_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inadimplentes`
--

DROP TABLE IF EXISTS `vw_inadimplentes`;
/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inadimplentes` AS SELECT 
 1 AS `animal`,
 1 AS `tutor`,
 1 AS `telefone_tutor`,
 1 AS `data_hora`,
 1 AS `status_consulta`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'db_pet_vida'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_classificar_valor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_classificar_valor`(valor_consulta DECIMAL(10,2)) RETURNS varchar(30) CHARSET utf8mb4
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_idade_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_idade_animal`(data_nascimento DATE) RETURNS varchar(50) CHARSET utf8mb4
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_qtd_consultas_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_qtd_consultas_animal`(animal_id INT UNSIGNED) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE total_consultas INT DEFAULT 0;
    
    SELECT COUNT(*) INTO total_consultas
    FROM `consultas`
    WHERE animais_id_animais = animal_id;
    
    RETURN total_consultas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_status_emoji` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_status_emoji`(status_consulta VARCHAR(20)) RETURNS varchar(40) CHARSET utf8mb4
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_gasto_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_gasto_tutor`(tutor_id INT UNSIGNED) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE total_gasto DECIMAL(10,2);
    
    -- Soma o valor das consultas dos animais do tutor, ignorando as canceladas
    SELECT IFNULL(SUM(c.valor), 0.00) INTO total_gasto
    FROM consultas c
    INNER JOIN animais a ON c.animais_id_animais = a.id_animais
    WHERE a.tutores_id_tutores = tutor_id 
      AND c.status <> 'cancelada';
      
    RETURN total_gasto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_agendar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agendar_consulta`(

    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)

)
BEGIN

    DECLARE v_animal INT;
    DECLARE v_veterinario INT;
    DECLARE v_horario INT;

    SELECT id_animais
    INTO v_animal
    FROM animais
    WHERE id_animais = p_animal_id;

    SELECT id_veterinarios
    INTO v_veterinario
    FROM veterinarios
    WHERE id_veterinarios = p_vet_id;

    SELECT COUNT(*)
    INTO v_horario
    FROM consultas
    WHERE veterinarios_id_veterinarios = p_vet_id
    AND data_hora = p_data_hora;

    IF v_animal IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Animal não encontrado.';
    END IF;

    IF v_veterinario IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Veterinário não encontrado.';
    END IF;

    IF v_horario > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Horário já ocupado.';
    END IF;

    START TRANSACTION;

        INSERT INTO consultas(
            animais_id_animais,
            veterinarios_id_veterinarios,
            data_hora,
            valor,
            status
        )
        VALUES(
            p_animal_id,
            p_vet_id,
            p_data_hora,
            p_valor,
            'agendada'
        );

        INSERT INTO pagamentos(
            consultas_id_consultas,
            valor_pago,
            forma_pagamento,
            data_pagamento,
            status
        )
        VALUES(
            LAST_INSERT_ID(),
            0.00,
            'dinheiro',
            NOW(),
            'pendente'
        );

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cadastrar_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cadastrar_animal`(

    IN p_nome VARCHAR(50),
    IN p_especie_id INT,
    IN p_raca VARCHAR(30),
    IN p_nascimento DATE,
    IN p_tutor_id INT,
    OUT p_novo_id INT

)
BEGIN

    DECLARE v_tutor INT;
    DECLARE v_especie INT;

    SELECT id_tutores
    INTO v_tutor
    FROM tutores
    WHERE id_tutores = p_tutor_id;

    SELECT id_especies
    INTO v_especie
    FROM especies
    WHERE id_especies = p_especie_id;

    IF v_tutor IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tutor não encontrado.';
    END IF;

    IF v_especie IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Espécie não encontrada.';
    END IF;

    START TRANSACTION;

        INSERT INTO animais(
            nome,
            especies_id_especies,
            raca,
            data_nascimento,
            tutores_id_tutores
        )
        VALUES(
            p_nome,
            p_especie_id,
            p_raca,
            p_nascimento,
            p_tutor_id
        );

        SET p_novo_id = LAST_INSERT_ID();

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cancelar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cancelar_consulta`(

    IN p_consulta_id INT

)
BEGIN

    DECLARE v_consulta INT;

    SELECT id_consultas
    INTO v_consulta
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF v_consulta IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Consulta não encontrada.';
    END IF;

    START TRANSACTION;

        UPDATE consultas
        SET status = 'cancelada'
        WHERE id_consultas = p_consulta_id;

        UPDATE pagamentos
        SET status = 'cancelado'
        WHERE consultas_id_consultas = p_consulta_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_concluir_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_concluir_consulta`(

    IN p_consulta_id INT,
    IN p_diagnostico VARCHAR(45)

)
BEGIN

    DECLARE v_consulta INT;

    SELECT id_consultas
    INTO v_consulta
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF v_consulta IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Consulta não encontrada.';
    END IF;

    START TRANSACTION;

        UPDATE consultas
        SET
            status = 'concluida',
            diagnostico = p_diagnostico
        WHERE id_consultas = p_consulta_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_pagamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pagamento`(

    IN p_consulta_id INT,
    IN p_forma_pagamento VARCHAR(20)

)
BEGIN

    DECLARE v_pagamento INT;
    DECLARE v_status VARCHAR(20);

    SELECT id_pagamentos, status
    INTO v_pagamento, v_status
    FROM pagamentos
    WHERE consultas_id_consultas = p_consulta_id;

    IF v_pagamento IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento não encontrado.';
    END IF;

    IF v_status = 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento já realizado.';
    END IF;

    START TRANSACTION;

        UPDATE pagamentos
        SET
            forma_pagamento = p_forma_pagamento,
            status = 'pago'
        WHERE consultas_id_consultas = p_consulta_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_pet_vida`
--

USE `db_pet_vida`;

--
-- Final view structure for view `vw_agenda_hoje`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda_hoje` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`status_consulta` AS `status_consulta`,`vw_consultas_completas`.`diagnostico` AS `diagnostico`,`vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone_tutor` AS `telefone_tutor`,`vw_consultas_completas`.`veterinario` AS `veterinario`,`vw_consultas_completas`.`especialidade` AS `especialidade`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where (cast(`vw_consultas_completas`.`data_hora` as date) = curdate()) order by `vw_consultas_completas`.`data_hora` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_animais_detalhados`
--

/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_animais_detalhados` AS select `a`.`id_animais` AS `id_animais`,`a`.`nome` AS `animal`,`t`.`nome` AS `tutores`,`e`.`nome` AS `especies`,count(`c`.`id_consultas`) AS `total_consultas` from (((`animais` `a` join `especies` `e` on((`a`.`especies_id_especies` = `e`.`id_especies`))) join `tutores` `t` on((`a`.`tutores_id_tutores` = `t`.`id_tutores`))) left join `consultas` `c` on((`a`.`id_animais` = `c`.`animais_id_animais`))) group by `a`.`id_animais`,`a`.`nome`,`t`.`nome`,`e`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_consultas_completas`
--

/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_consultas_completas` AS select `c`.`data_hora` AS `data_hora`,`c`.`status` AS `status_consulta`,`c`.`diagnostico` AS `diagnostico`,`a`.`nome` AS `animal`,`t`.`nome` AS `tutor`,`t`.`telefone` AS `telefone_tutor`,`v`.`nome` AS `veterinario`,`v`.`especialidade` AS `especialidade`,`p`.`forma_pagamento` AS `forma_pagamento`,`p`.`status` AS `status_pagamento` from (((((`consultas` `c` join `animais` `a` on((`c`.`animais_id_animais` = `a`.`id_animais`))) join `especies` `e` on((`a`.`especies_id_especies` = `e`.`id_especies`))) join `tutores` `t` on((`a`.`tutores_id_tutores` = `t`.`id_tutores`))) join `veterinarios` `v` on((`c`.`veterinarios_id_veterinarios` = `v`.`id_veterinarios`))) left join `pagamentos` `p` on((`c`.`id_consultas` = `p`.`consultas_id_consultas`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_mensal`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_mensal` AS select year(`c`.`data_hora`) AS `ano`,month(`c`.`data_hora`) AS `mes`,`v`.`nome` AS `veterinario`,count(`c`.`id_consultas`) AS `total_consultas`,sum(`c`.`valor`) AS `faturamento_total` from (`consultas` `c` join `veterinarios` `v` on((`c`.`veterinarios_id_veterinarios` = `v`.`id_veterinarios`))) group by year(`c`.`data_hora`),month(`c`.`data_hora`),`v`.`id_veterinarios`,`v`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inadimplentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inadimplentes` AS select `vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone_tutor` AS `telefone_tutor`,`vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`status_consulta` AS `status_consulta`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where ((`vw_consultas_completas`.`status_consulta` = 'concluida') and ((`vw_consultas_completas`.`status_pagamento` is null) or (`vw_consultas_completas`.`status_pagamento` = 'pago'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-16 22:38:58
