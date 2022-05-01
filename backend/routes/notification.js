const express = require('express')
const router = express.Router()

const Notification = require('../models/notification');
const User = require('../models/user')

router.get('/', (req, res) => {
    Notification.find({to: req.user.brand})
        .then(notifications => {
            if(!notifications) res.status(404).json({ error: 'notifications not found' })
            else {
                res.status(200).json(notifications)
            }
        })
});

module.exports = router