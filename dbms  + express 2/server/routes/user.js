const express = require('express');
const jwt = require('jsonwebtoken');
const { User, Course } = require('../db');
const { JWT_SECRET } = require('../config');
const userAuth = require('../middleware/user');

const router = express.Router();

// User Signup
router.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Check if user already exists
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Create new user
        const newUser = new User({ username, password, purchasedCourses: [] });
        await newUser.save();

        res.status(201).json({ message: 'User created successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error creating user', error: error.message });
    }
});

// User Signin
router.post('/signin', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Find user by username and password
        const user = await User.findOne({ username, password });
        if (!user) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign({ username, role: 'user' }, JWT_SECRET, { expiresIn: '24h' });

        res.json({ message: 'Signin successful', token });
    } catch (error) {
        res.status(500).json({ message: 'Error signing in', error: error.message });
    }
});

// Get All Published Courses
router.get('/courses', async (req, res) => {
    try {
        // Find all published courses
        const courses = await Course.find({ published: true });

        res.json({ courses });
    } catch (error) {
        res.status(500).json({ message: 'Error fetching courses', error: error.message });
    }
});

// Purchase Course (Protected Route)
router.post('/courses/:courseId', userAuth, async (req, res) => {
    try {
        const { courseId } = req.params;
        const username = req.username; // From middleware

        // Find the course
        const course = await Course.findById(courseId);
        if (!course) {
            return res.status(404).json({ message: 'Course not found' });
        }

        // Find the user and add course to purchasedCourses
        const user = await User.findOne({ username });
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Check if course already purchased
        if (user.purchasedCourses.includes(courseId)) {
            return res.status(400).json({ message: 'Course already purchased' });
        }

        // Add course to user's purchased courses
        user.purchasedCourses.push(courseId);
        await user.save();

        res.json({ message: 'Course purchased successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error purchasing course', error: error.message });
    }
});

module.exports = router;
