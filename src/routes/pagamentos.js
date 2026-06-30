const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// POST /api/pagamentos/:consulta_id — chama CALL sp_registrar_pagamento
router.post('/:consulta_id', async (req, res) => {
    try {
        const { valor_pago, forma_pagamento } = req.body;

        if (!valor_pago || !forma_pagamento) {
            return res.status(400).json({
                success: false,
                message: 'Campos obrigatórios faltando: valor_pago, forma_pagamento'
            });
        }

        const formasPagamento = ['pix', 'cartao', 'dinheiro', 'convênio'];
        if (!formasPagamento.includes(forma_pagamento)) {
            return res.status(400).json({
                success: false,
                message: 'Forma de pagamento inválida. Opções: pix, cartao, dinheiro, convênio'
            });
        }

        const connection = await pool.getConnection();
        const [result] = await connection.query(
            'CALL sp_registrar_pagamento(?, ?, ?)',
            [req.params.consulta_id, valor_pago, forma_pagamento]
        );
        connection.release();

        res.status(201).json({
            success: true,
            data: result[0],
            message: 'Pagamento registrado com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao registrar pagamento',
            error: error.message
        });
    }
});

// GET /api/pagamentos/:id — obtém um pagamento específico
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [pagamento] = await connection.query(
            'SELECT * FROM pagamentos WHERE id_pagamentos = ?',
            [req.params.id]
        );
        connection.release();

        if (pagamento.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Pagamento não encontrado'
            });
        }

        res.status(200).json({
            success: true,
            data: pagamento[0],
            message: 'Pagamento encontrado'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar pagamento',
            error: error.message
        });
    }
});

module.exports = router;
