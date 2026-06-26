const app = require('./src/app');
require('dontev').config();

app.use(cors());

const PORT = process.env.PORT || 3000;
app.listen(PORT,()=> {
    console.log(`Server is running on port ${PORT}`);

});