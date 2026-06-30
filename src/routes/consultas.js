const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/agenda/:data — usa vw_consultas_completas filtrada
router.get('/agenda/:data', async (req, res) => {
    try {
        const data = req.params.data; // formato: YYYY-MM-DD
        const connection = await pool.getConnection();
        
        const [consultas] = await connection.query(
            `SELECT * FROM vw_consultas_completas 
             WHERE DATE(data_hora) = ? 
             ORDER BY data_hora`,
            [data]
        );
        connection.release();

        res.status(200).json({
            success: true,
            data: consultas,
            date: data,
            message: 'Agenda listada com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao listar agenda',
            error: error.message
        });
    }
});

// POST /api/consultas — chama CALL sp_agendar_consulta
router.post('/', async (req, res) => {
    try {
        const { animal_id, veterinario_id, data_hora, valor } = req.body;

        // Validações básicas
        if (!animal_id || !veterinario_id || !data_hora || !valor) {
            return res.status(400).json({
                success: false,
                message: 'Campos obrigatórios faltando: animal_id, veterinario_id, data_hora, valor'
            });
        }

        const connection = await pool.getConnection();
        const [result] = await connection.query(
            'CALL sp_agendar_consulta(?, ?, ?, ?)',
            [animal_id, veterinario_id, data_hora, valor]
        );
        connection.release();

        res.status(201).json({
            success: true,
            data: result[0],
            message: 'Consulta agendada com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao agendar consulta',
            error: error.message
        });
    }
});

// GET /api/consultas/:id — obtém uma consulta específica
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [consultas] = await connection.query(
            'SELECT * FROM vw_consultas_completas WHERE id_consultas = ?',
            [req.params.id]
        );
        connection.release();

        if (consultas.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Consulta não encontrada'
            });
        }

        res.status(200).json({
            success: true,
            data: consultas[0],
            message: 'Consulta encontrada'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar consulta',
            error: error.message
        });
    }
});

// PUT /api/consultas/:id/concluir — chama CALL sp_concluir_consulta
router.put('/:id/concluir', async (req, res) => {
    try {
        const { diagnostico } = req.body;

        if (!diagnostico) {
            return res.status(400).json({
                success: false,
                message: 'Campo obrigatório faltando: diagnostico'
            });
        }

        const connection = await pool.getConnection();
        const [result] = await connection.query(
            'CALL sp_concluir_consulta(?, ?)',
            [req.params.id, diagnostico]
        );
        connection.release();

        res.status(200).json({
            success: true,
            data: result[0],
            message: 'Consulta concluída com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao concluir consulta',
            error: error.message
        });
    }
});

module.exports = router;
