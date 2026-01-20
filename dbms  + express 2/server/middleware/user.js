const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../config');

// User authentication middleware
const userAuth = (req, res, next) => {
    // Extract token from Authorization header
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(403).json({ message: 'Authorization header missing' });
    }

    // Split "Bearer <token>" to get the token
    const token = authHeader.split(' ')[1];

    if (!token) {
        return res.status(403).json({ message: 'Token missing' });
    }

    try {
        // Verify the token using JWT_SECRET
        const decoded = jwt.verify(token, JWT_SECRET);

        // Attach username to request object for use in routes
        req.username = decoded.username;
        next();
    } catch (error) {
        return res.status(403).json({ message: 'Invalid or expired token' });
    }
};

module.exports = userAuth;
