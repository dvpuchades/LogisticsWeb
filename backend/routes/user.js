const express = require('express')
const router = express.Router()

const User = require('../models/user')

router.get('/', (req, res) => {
    User.find({brand: req.user.brand})
        .then(users => {
            if (!users) res.status(404).json({error: 'not user found'})
            else {
                let showableUsers = []
                users.forEach(user => {
                    showableUsers.push({
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        restaurant: user.restaurant
                    })
                })
                res.status(200).json(showableUsers)
            } 
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/active', (req, res) => {
    let showableUsers = []
    Active.find({finishTime: null})
        .then( actives => {
            if(!actives) res.status(404).json({error: 'not active users'})
            actives.forEach(active => {
                User.findOne({_id: active.user})
                .then(user => {
                    showableUsers.push({
                        name: user.name,
                        email: user.email,
                        phone: user.phone
                    })
                })
                res.status(200).json(showableUsers)
            })
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

module.exports = router