const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/animais — usa vw_animais_detalhados
router.get('/', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [animais] = await connection.query('SELECT * FROM vw_animais_detalhados');
        connection.release();

        res.status(200).json({
            success: true,
            data: animais,
            message: 'Animais listados com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao listar animais',
            error: error.message
        });
    }
});

// GET /api/animais/:id — obtém um animal específico
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [animal] = await connection.query(
            'SELECT * FROM vw_animais_detalhados WHERE id_animais = ?',
            [req.params.id]
        );
        connection.release();

        if (animal.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Animal não encontrado'
            });
        }

        res.status(200).json({
            success: true,
            data: animal[0],
            message: 'Animal encontrado'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar animal',
            error: error.message
        });
    }
});

module.exports = router;
