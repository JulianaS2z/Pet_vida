app.get('/api', (req, res) => {
    res.json({ message: 'Pet Vida API',status:'Online' });
});

app.use('/api')

app.use('/api/veterinarios', require ('./routes/veterinarios'));
app.use('/api/animais', require ('./routes/animais'));
app.use('/api/consultas', require ('./routes/consultas'));
app.use('/api/especies', require ('./routes/especies'));
app.use('/api/pagamentos', require ('./routes/pagamentos'));
app.use('/api/tutores', require ('./routes/tutores'));

module.exports = pool;