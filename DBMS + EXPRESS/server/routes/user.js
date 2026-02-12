const express = require('express');
const jwt = require('jsonwebtoken');
const { User, Course } = require('../db');
const config = require('../config');
const userMiddleware = require('../middleware/user');

const router = express.Router();

// User Signup
router.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Validate input
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        // Check if user already exists
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Create new user
        const newUser = new User({
            username,
            password, // In production, hash the password using bcrypt
            purchasedCourses: []
        });

        await newUser.save();

        res.status(201).json({ message: 'User created successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// User Signin
router.post('/signin', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Validate input
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        // Find user
        const user = await User.findOne({ username, password });

        if (!user) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign(
            { username: user.username, role: 'user' },
            config.JWT_SECRET,
            { expiresIn: '24h' }
        );

        res.status(200).json({ message: 'Signin successful', token });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Get All Published Courses
router.get('/courses', async (req, res) => {
    try {
        // Find all published courses
        const courses = await Course.find({ published: true });

        res.status(200).json({ courses });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Purchase a Course (Protected Route)
router.post('/courses/:courseId', userMiddleware, async (req, res) => {
    try {
        const { courseId } = req.params;
        const username = req.username; // Retrieved from middleware

        // Find the course
        const course = await Course.findById(courseId);

        if (!course) {
            return res.status(404).json({ message: 'Course not found' });
        }

        // Find the user
        const user = await User.findOne({ username });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Check if course is already purchased
        if (user.purchasedCourses.includes(courseId)) {
            return res.status(400).json({ message: 'Course already purchased' });
        }

        // Add course to user's purchasedCourses array
        user.purchasedCourses.push(courseId);
        await user.save();

        res.status(200).json({ message: 'Course purchased successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

module.exports = router;
