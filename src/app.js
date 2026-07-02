const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '..', 'Front-end')));

// Health check
app.get('/api', (req, res) => {
    res.json({ message: 'Pet Vida API', status: 'Online' });
});

// Rotas
app.use('/api/veterinarios', require('./routes/veterinarios'));
app.use('/api/animais', require('./routes/animais'));
app.use('/api/consultas', require('./routes/consultas'));
app.use('/api/especies', require('./routes/especies'));
app.use('/api/pagamentos', require('./routes/pagamentos'));
app.use('/api/tutores', require('./routes/tutores'));
app.use('/api/relatorios', require('./routes/relatorios'));

// Rota 404
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: 'Rota não encontrada'
    });
});

// Tratamento de erros global
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({
        success: false,
        message: 'Erro interno do servidor',
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});

module.exports = app;
