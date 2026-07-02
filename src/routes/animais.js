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
router.post('/', async (req, res) => {
    let connection;

    try {
        const {
            nome,
            especie_id,
            especies_id_especies,
            raca,
            data_nascimento,
            tutor_id,
            tutores_id_tutores
        } = req.body;

        const especieId = especie_id || especies_id_especies;
        const tutorId = tutor_id || tutores_id_tutores;

        if (!nome || !especieId || !tutorId) {
            return res.status(400).json({
                success: false,
                message: 'Campos obrigatorios faltando: nome, especie_id, tutor_id'
            });
        }

        connection = await pool.getConnection();
        const [result] = await connection.query(
            `INSERT INTO animais (nome, especies_id_especies, raca, data_nascimento, tutores_id_tutores)
             VALUES (?, ?, ?, ?, ?)`,
            [nome, especieId, raca || null, data_nascimento || null, tutorId]
        );

        const [animal] = await connection.query(
            'SELECT * FROM vw_animais_detalhados WHERE id_animais = ?',
            [result.insertId]
        );

        res.status(201).json({
            success: true,
            data: animal[0],
            message: 'Animal cadastrado com sucesso'
        });
    } catch (error) {
        const status = error.code === 'ER_NO_REFERENCED_ROW_2' ? 400 : 500;

        res.status(status).json({
            success: false,
            message: status === 400 ? 'Especie ou tutor nao encontrado' : 'Erro ao cadastrar animal',
            error: error.message
        });
    } finally {
        if (connection) {
            connection.release();
        }
    }
});

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
