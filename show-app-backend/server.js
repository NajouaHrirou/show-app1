require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const showRoutes = require('./routes/shows');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static('uploads')); // Servir les fichiers d'images
app.use('/shows', showRoutes); // Utilisation des routes de gestion des shows

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
