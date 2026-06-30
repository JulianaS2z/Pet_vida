const express = require('express');
const router = express.Router();
const pool = require('../config/database');

// GET /api/relatorios/dashboard — query do dashboard financeiro
router.get('/dashboard', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        
        // Total de consultas
        const [totalConsultas] = await connection.query(
            'SELECT COUNT(*) as total FROM consultas'
        );

        // Faturamento total
        const [faturamento] = await connection.query(
            'SELECT SUM(valor) as total FROM consultas WHERE status = "concluida"'
        );

        // Consultas por status
        const [statusConsultas] = await connection.query(
            `SELECT status, COUNT(*) as total 
             FROM consultas 
             GROUP BY status`
        );

        // Pagamentos por forma
        const [pagamentosForma] = await connection.query(
            `SELECT forma_pagamento, COUNT(*) as total, SUM(valor_pago) as valor_total 
             FROM pagamentos 
             GROUP BY forma_pagamento`
        );

        // Faturamento mensal
        const [faturamentoMensal] = await connection.query(
            `SELECT 
                YEAR(c.data_hora) AS ano,
                MONTH(c.data_hora) AS mes,
                SUM(c.valor) AS faturamento_total,
                COUNT(c.id_consultas) AS total_consultas
             FROM consultas c
             WHERE c.status = 'concluida'
             GROUP BY YEAR(c.data_hora), MONTH(c.data_hora)
             ORDER BY ano DESC, mes DESC`
        );

        connection.release();

        res.status(200).json({
            success: true,
            data: {
                totalConsultas: totalConsultas[0],
                faturamentoTotal: faturamento[0],
                statusConsultas: statusConsultas,
                pagamentosForma: pagamentosForma,
                faturamentoMensal: faturamentoMensal
            },
            message: 'Dashboard financeiro carregado com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao carregar dashboard',
            error: error.message
        });
    }
});

// GET /api/relatorios/inadimplentes — usa vw_inadimplentes
router.get('/inadimplentes', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [inadimplentes] = await connection.query(
            'SELECT * FROM vw_inadimplentes ORDER BY data_hora DESC'
        );
        connection.release();

        res.status(200).json({
            success: true,
            data: inadimplentes,
            total: inadimplentes.length,
            message: 'Relatório de inadimplentes carregado com sucesso'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Erro ao carregar relatório de inadimplentes',
            error: error.message
        });
    }
});

module.exports = router;
