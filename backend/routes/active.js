const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Active = require('../models/active');
const buffer = require('../util/buffer');


router.get('/', (req, res) => {
    let showableUsers = []
    Active.find({brand: req.user.brand, finishTime: { $exists: false }})
        .then( actives => {
            if(actives.length == 0) res.status(404).json({error: 'not active users'})
            let totalActives = actives.length
            let processedActives = 0
            actives.forEach(active => {
                User.findOne({_id: active.user})
                    .then(user => {
                        showableUsers.push({
                            name: user.name,
                            email: user.email,
                            phone: user.phone
                        })
                        processedActives++
                        if (processedActives == totalActives) res.status(200).json(showableUsers)
                    })
            })
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/:restaurantId', (req, res) => {
    let showableUsers = []
    Active.find({brand: req.user.brand, finishTime: { $exists: false }})
        .then( actives => {
            if(actives.length == 0) res.status(404).json({error: 'not active users'})
            else{
                let totalActives = actives.length
                let processedActives = 0
                actives.forEach(active => {
                    if (!active) res.status(404).json({error: 'not users active'})
                    User.findOne({_id: active.user})
                        .then(
                            user => {
                                if (user.restaurant == req.params.restaurantId){
                                    showableUsers.push({
                                        name: user.name,
                                        email: user.email,
                                        phone: user.phone
                                    })
                                }
                                processedActives++
                                if (processedActives == totalActives) {
                                    if (showableUsers.length != 0) res.status(200).json(showableUsers)
                                    else res.status(404).json({error: 'not users active'})
                                }
                        })
                })
            }
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.put('/', (req, res) => {
    setActive(req, res, req.user._id)
});

function setActive(req, res, userId) {
    console.log(req.body.active)
    if (typeof req.body.active === 'undefined') res.status(400).json({error: 'insert valid parameters'})
    else if (req.body.active == true){
        buffer.set(req.user, {
            id: req.user._id,
            name: req.user.name, 
            email: req.user.email, 
            restaurant: req.user.restaurant, 
            phone: req.user.phone,
            privilege: req.user.privilege,
            longitude: req.user.longitude, 
            latitude: req.user.latitude}, 'activate', 'user')
        Active.find({user: userId, finishTime: { $exists: false }})
            .then(active => {
                if (active.length == 0){
                    const newActive = Active({
                        user: userId,
                        brand: req.user.brand,
                        initTime: Date()
                    })
                    newActive.save()
                        .then(active => {
                            res.status(200).json(active)
                        })
                        .catch(error => {
                            res.status(500).json(error)
                        })
                }
                else res.status(200).json('user already active')
            })
            .catch(error => {
                res.status(500).json(error)
            })
    }
    else {
        buffer.set(req.user, {_id: userId}, 'deactivate', 'user')
        Active.findOneAndUpdate({user: userId}, {finishTime: Date()}, {new: true}, (error, updatedActive) => {
            if (error) return res.status(500).json({error})
            else if (!updatedActive) res.status(400).json({error: 'user was not active'})
            else res.status(200).json(updatedActive)
        })
    }
}

module.exports = router