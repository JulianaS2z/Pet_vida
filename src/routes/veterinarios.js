const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/veterinarios — lista veterinários
router.get('/', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [veterinarios] = await connection.query('SELECT * FROM veterinarios');
        connection.release();

        res.status(200).json({
            success: true,
            data: veterinarios,
            message: 'Veterinários listados com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao listar veterinários',
            error: error.message
        });
    }
});

// GET /api/veterinarios/:id — obtém um veterinário específico
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [veterinario] = await connection.query(
            'SELECT * FROM veterinarios WHERE id_veterinarios = ?',
            [req.params.id]
        );
        connection.release();

        if (veterinario.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Veterinário não encontrado'
            });
        }

        res.status(200).json({
            success: true,
            data: veterinario[0],
            message: 'Veterinário encontrado'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar veterinário',
            error: error.message
        });
    }
});

module.exports = router;
