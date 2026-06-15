INSERT INTO especies (nome) VALUES
('Cachorro'),
('Gato'),
('Ave'),
('Peixe'),
('Réptil');

INSERT INTO animais
(nome, especies_id_especies, raca,
data_nascimento, tutores_id_tutores)
VALUES
('Flok', 1, 'Poodle', '2022-07-14', 4),
('Channy', 2, 'Persa', '2023-01-20', 5),
('Pipoco', 1, 'Golden Retriever', '2021-11-05', 6),
('Fred', 1, 'Beagle', '2020-04-12', 7),
('Mia', 2, 'Angorá', '2022-09-18', 1),
('Bob', 1, 'Pastor Alemão', '2019-11-30', 2),
('Bela', 1, 'Shih Tzu', '2021-06-25', 3),
('Zeus', 1, 'Rottweiler', '2018-03-14', 4),
('Nina', 1, 'Vira-lata', '2023-02-10', 1),
('Luke', 1, 'Bulldog Frances', '2022-05-22', 3),
('Amora', 2, 'Maine Coon', '2021-08-05', 5),
('Pipoca', 1, 'Pug', '2023-11-12', 6),
('Cacau', 1, 'Cocker Spaniel', '2020-01-28', 7),
('Simba', 2, 'Persa', '2022-03-03', 8),
('Maya', 1, 'Border Collie', '2021-10-15', 1);

INSERT INTO consultas 
(animais_id_animais, veterinarios_id_veterinarios, data_hora, diagnostico, valor, status) 
VALUES
(1, 1, '2025-05-10 14:00:00', 'Vacinação V10', 150.00, 'concluida'),
(2, 2, '2025-05-11 09:30:00', 'Check-up de rotina', 120.00, 'em_atendimento'),
(3, 3, '2025-05-11 11:00:00', 'Tratamento de otite', 180.00, 'agendada'),
(4, 1, '2025-05-12 15:15:00', 'Exame de sangue', 200.00, 'concluida'),
(5, 2, '2025-05-13 16:00:00', 'Limpeza de tártaro', 350.00, 'cancelada'),
(6, 3, '2025-05-14 10:00:00', 'Consulta dermatológica', 160.00, 'concluida'),
(7, 1, '2025-05-14 14:30:00', 'Aplicação de antipulgas', 90.00, 'em_atendimento'),
(8, 2, '2025-05-15 08:00:00', 'Castração preventiva', 450.00, 'agendada'),
(9, 3, '2025-05-15 13:00:00', 'Tratamento de gastrite', 220.00, 'concluida'),
(10, 1, '2025-05-16 11:30:00', 'Retirada de pontos', 80.00, 'cancelada'),
(11, 2, '2025-05-16 16:45:00', 'Vacinação Antirrábica', 150.00, 'em_atendimento'),
(12, 3, '2025-05-17 09:00:00', 'Exame de ultrassom', 250.00, 'concluida'),
(13, 1, '2025-05-17 10:30:00', 'Avaliação cirúrgica', 180.00, 'agendada'),
(14, 2, '2025-05-18 14:00:00', 'Curativo em pata', 95.00, 'concluida'),
(15, 3, '2025-05-18 15:30:00', 'Tratamento de sarna', 190.00, 'cancelada'),
(1, 1, '2025-05-19 11:00:00', 'Consulta oftálmica', 170.00, 'concluida'),
(2, 2, '2025-05-19 16:00:00', 'Desparasitação interna', 75.00, 'agendada'),
(3, 3, '2025-05-20 09:15:00', 'Corte de unhas e higiene', 60.00, 'concluida'),
(4, 1, '2025-05-20 13:45:00', 'Remoção de corpo estranho', 310.00, 'em_atendimento'),
(15, 2, '2025-05-21 10:00:00', 'Check-up geriátrico', 210.00, 'agendada');

INSERT INTO tutores
(nome, cpf, email, telefone)
VALUES
('Kaique Aquino', '521.843.901-44', 'kai@gmail.com', '71981249033'),
('joel Macena', '364.715.028-91', 'mace@gmail.com', '71974351280'),
('Alexande Santos', '892.431.765-07', 'alex@gmail.com', '71962058471'),
('Nilton Santana', '159.284.637-55', 'satan@gmail.com', '71993175842'),
('Lucas Pereira', '987.654.321-00', 'lucas@gmail.com', '71912345678'),
('Beatriz Gomes', '456.789.123-11', 'beatriz@gmail.com', '71954321678'),
('Rodrigo Martins', '789.123.456-22', 'rodrigo@gmail.com', '71967854321'),
('Mariana Rocha', '321.654.987-33', 'mariana@gmail.com', '71934567812');

INSERT INTO veterinarios
(nome, crmv, especialidade, telefone)
VALUES
('Juliana dos Santos', 'CRMV001', 'Clínico Geral', '(71)94002-8922'),
('Maria Almeida', 'CRMV002', 'Cardiologia', '(71)92424-9595'),
('Nilson Fernado', 'CRMV003', 'Dermatologia', '(71)93131-2525');

INSERT INTO pagamentos 
(
consultas_id_consultas,
valor_pago,
forma_pagamento,
data_pagamento,
status
) 
VALUES
(1, 150.00, 'pix', '2025-05-10 15:00:00', 'pago'),
(2, 120.00, 'cartao', '2025-05-11 10:15:00', 'pago'),
(3, 180.00, 'dinheiro', '2025-05-11 11:45:00', 'pendente'),
(4, 200.00, 'pix', '2025-05-12 15:45:00', 'pago'),
(5, 350.00, 'convênio', '2025-05-13 16:30:00', 'cancelado'),
(6, 160.00, 'dinheiro', '2025-05-14 10:45:00', 'pago'),
(7, 90.00, 'pix', '2025-05-14 15:00:00', 'pago'),
(8, 450.00, 'cartao', '2025-05-15 09:30:00', 'pendente'),
(9, 220.00, 'cartao', '2025-05-15 13:45:00', 'pago'),
(10, 80.00, 'dinheiro', '2025-05-16 12:00:00', 'pago'),
(11, 150.00, 'pix', '2025-05-16 17:15:00', 'pendente'),
(12, 250.00, 'convênio', '2025-05-17 09:50:00', 'pago'),
(13, 180.00, 'cartao', '2025-05-17 11:10:00', 'pago'),
(14, 95.00, 'pix', '2025-05-18 14:20:00', 'pago'),
(15, 190.00, 'convênio', '2025-05-18 16:00:00', 'cancelado'),
(16, 170.00, 'dinheiro', '2025-05-19 11:40:00', 'pago'),
(17, 75.00, 'pix', '2025-05-19 16:15:00', 'pendente'),
(18, 60.00, 'cartao', '2025-05-20 09:45:00', 'pago'),
(19, 310.00, 'cartao', '2025-05-20 14:30:00', 'pago'),
(20, 210.00, 'pix', '2025-05-21 10:45:00', 'pago');