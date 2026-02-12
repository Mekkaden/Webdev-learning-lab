const jwt = require('jsonwebtoken');
const config = require('../config');

// Admin authentication middleware
const adminMiddleware = (req, res, next) => {
    // Extract token from Authorization header
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(403).json({ message: 'Authorization header missing' });
    }

    // Extract token from "Bearer <token>" format
    const token = authHeader.split(' ')[1];

    if (!token) {
        return res.status(403).json({ message: 'Token missing' });
    }

    try {
        // Verify the token
        const decoded = jwt.verify(token, config.JWT_SECRET);

        // Token is valid, proceed to next middleware/route
        req.admin = decoded;
        next();
    } catch (error) {
        // Token verification failed
        return res.status(403).json({ message: 'Invalid or expired token' });
    }
};

module.exports = adminMiddleware;
