const express = require('express');
const app = express();
const projectRoutes = require('./routes/projectRoutes');
const interestRoutes = require('./routes/interestRoutes');

app.use(express.json());
app.use('/api/projects', projectRoutes);
app.use('/api/interest', interestRoutes);

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
