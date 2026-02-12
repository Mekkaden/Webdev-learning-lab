const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const adminRouter = require('./routes/admin');
const userRouter = require('./routes/user');

// Initialize Express app
const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/admin', adminRouter);
app.use('/users', userRouter);

// Root endpoint
app.get('/', (req, res) => {
    res.json({ message: 'Welcome to Course Selling App API' });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
