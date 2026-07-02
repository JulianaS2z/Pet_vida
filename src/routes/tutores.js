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
router.post('/', async (req, res) => {
    let connection;

    try {
        const { nome, cpf, email, telefone } = req.body;

        if (!nome || !cpf) {
            return res.status(400).json({
                success: false,
                message: 'Campos obrigatorios faltando: nome, cpf'
            });
        }

        connection = await pool.getConnection();
        const [result] = await connection.query(
            `INSERT INTO tutores (nome, cpf, email, telefone)
             VALUES (?, ?, ?, ?)`,
            [nome, cpf, email || null, telefone || null]
        );

        const [tutor] = await connection.query(
            'SELECT * FROM tutores WHERE id_tutores = ?',
            [result.insertId]
        );

        res.status(201).json({
            success: true,
            data: tutor[0],
            message: 'Tutor cadastrado com sucesso'
        });
    } catch (error) {
        const status = error.code === 'ER_DUP_ENTRY' ? 409 : 500;

        res.status(status).json({
            success: false,
            message: status === 409 ? 'CPF ou email ja cadastrado' : 'Erro ao cadastrar tutor',
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
