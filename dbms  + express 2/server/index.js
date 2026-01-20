const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const adminRouter = require('./routes/admin');
const userRouter = require('./routes/user');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/admin', adminRouter);
app.use('/users', userRouter);

// Health check endpoint
app.get('/', (req, res) => {
    res.json({ message: 'Course Selling API is running' });
});

// Start server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
