const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/tutores — lista tutores
router.get('/', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [tutores] = await connection.query('SELECT * FROM tutores');
        connection.release();

        res.status(200).json({
            success: true,
            data: tutores,
            message: 'Tutores listados com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao listar tutores',
            error: error.message
        });
    }
});

// GET /api/tutores/:id — obtém um tutor específico
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [tutor] = await connection.query(
            'SELECT * FROM tutores WHERE id_tutores = ?',
            [req.params.id]
        );
        connection.release();

        if (tutor.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Tutor não encontrado'
            });
        }

        res.status(200).json({
            success: true,
            data: tutor[0],
            message: 'Tutor encontrado'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar tutor',
            error: error.message
        });
    }
});

module.exports = router;
