const express = require('express');
const jwt = require('jsonwebtoken');
const { Admin, Course } = require('../db');
const { JWT_SECRET } = require('../config');
const adminAuth = require('../middleware/admin');

const router = express.Router();

// Admin Signup
router.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Check if admin already exists
        const existingAdmin = await Admin.findOne({ username });
        if (existingAdmin) {
            return res.status(400).json({ message: 'Admin already exists' });
        }

        // Create new admin
        const newAdmin = new Admin({ username, password });
        await newAdmin.save();

        res.status(201).json({ message: 'Admin created successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error creating admin', error: error.message });
    }
});

// Admin Signin
router.post('/signin', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Find admin by username and password
        const admin = await Admin.findOne({ username, password });
        if (!admin) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign({ username, role: 'admin' }, JWT_SECRET, { expiresIn: '24h' });

        res.json({ message: 'Signin successful', token });
    } catch (error) {
        res.status(500).json({ message: 'Error signing in', error: error.message });
    }
});

// Create Course (Protected Route)
router.post('/courses', adminAuth, async (req, res) => {
    try {
        const { title, description, price, imageLink, published } = req.body;

        // Create new course
        const newCourse = new Course({
            title,
            description,
            price,
            imageLink,
            published: published !== undefined ? published : true
        });

        await newCourse.save();

        res.status(201).json({ message: 'Course created successfully', courseId: newCourse._id });
    } catch (error) {
        res.status(500).json({ message: 'Error creating course', error: error.message });
    }
});

module.exports = router;
