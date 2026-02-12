const express = require('express');
const jwt = require('jsonwebtoken');
const { Admin, Course } = require('../db');
const config = require('../config');
const adminMiddleware = require('../middleware/admin');

const router = express.Router();

// Admin Signup
router.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Validate input
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        // Check if admin already exists
        const existingAdmin = await Admin.findOne({ username });
        if (existingAdmin) {
            return res.status(400).json({ message: 'Admin already exists' });
        }

        // Create new admin
        const newAdmin = new Admin({
            username,
            password // In production, hash the password using bcrypt
        });

        await newAdmin.save();

        res.status(201).json({ message: 'Admin created successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Admin Signin
router.post('/signin', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Validate input
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        // Find admin
        const admin = await Admin.findOne({ username, password });

        if (!admin) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign(
            { username: admin.username, role: 'admin' },
            config.JWT_SECRET,
            { expiresIn: '24h' }
        );

        res.status(200).json({ message: 'Signin successful', token });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Create Course (Protected Route)
router.post('/courses', adminMiddleware, async (req, res) => {
    try {
        const { title, description, price, imageLink, published } = req.body;

        // Validate input
        if (!title || !description || !price || !imageLink) {
            return res.status(400).json({ message: 'All course fields are required' });
        }

        // Create new course
        const newCourse = new Course({
            title,
            description,
            price,
            imageLink,
            published: published !== undefined ? published : true
        });

        await newCourse.save();

        res.status(201).json({
            message: 'Course created successfully',
            courseId: newCourse._id
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

module.exports = router;
