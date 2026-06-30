const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/especies — lista espécies
router.get('/', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [especies] = await connection.query('SELECT * FROM especies');
        connection.release();

        res.status(200).json({
            success: true,
            data: especies,
            message: 'Espécies listadas com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao listar espécies',
            error: error.message
        });
    }
});

// GET /api/especies/:id — obtém uma espécie específica
router.get('/:id', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [especie] = await connection.query(
            'SELECT * FROM especies WHERE id_especies = ?',
            [req.params.id]
        );
        connection.release();

        if (especie.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Espécie não encontrada'
            });
        }

        res.status(200).json({
            success: true,
            data: especie[0],
            message: 'Espécie encontrada'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao buscar espécie',
            error: error.message
        });
    }
});

module.exports = router;
