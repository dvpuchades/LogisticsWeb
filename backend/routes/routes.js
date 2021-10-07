const express = require('express')
const router = express.Router()

const Delivery = require('../models/delivery')
const User = require('../models/user')

router.post('/delivery', (req, res) => {
    
    const newDelivery = Delivery({
        uploadUser: req.user._id, 
        restaurant: req.body.restaurant,
        dealer: req.body.dealer, 
        address: req.body.address,
        postcode: req.body.postcode, 
        initTime: Date(),
        finishTime: req.body.finishTime,
        amount: req.body.amount,
        customer: req.body.customer
    })

    newDelivery.save()
        .then(Delivery => {
            res.status(200).send()
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/user', (req, res) => {
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

router.get('/user/active', (req, res) => {
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