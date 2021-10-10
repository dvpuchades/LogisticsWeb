const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Active = require('../models/active')
const Location = require('../models/location')

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

router.get('/:restaurantId', (req, res) => {
    User.find({brand: req.user.brand, restaurant: req.params.restaurantId})
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

router.get('/active/:restaurantId', (req, res) => {
    let showableUsers = []
    Active.find({finishTime: null})
        .then( actives => {
            if(!actives) res.status(404).json({error: 'not active users'})
            actives.forEach(active => {
                User.findOne({_id: active.user})
                    .then(user => {
                        if (user.restaurant == restaurantId){
                            showableUsers.push({
                                name: user.name,
                                email: user.email,
                                phone: user.phone
                            })
                        }
                    })
                res.status(200).json(showableUsers)
            })
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.put('/active/:id', (res, req) => {
    if (typeof req.body.active === 'undefined') res.status(400).json({error: 'insert valid parameters'})
    else if (req.body.active){
        Active.findOne({finishTime: null})
            .then(active => {
                if (!active){
                    const newActive = Active({
                        user: res.user,
                        initTime: Date()
                    })
                    Active.save(newActive)
                        .then(active => {
                            res.status(200).json(newActive)
                        })
                        .catch(error => {
                            res.status(500).json(error)
                        })
                }
                else res.status(200).json(active)
            })
            .catch(error => {
                res.status(500).json(error)
            })
    }
    else {
        Active.findOneAndUpdate({_id: req.params.id}, {finishTime: Date()}, {new: true}, (error, updatedActive) => {
            if (error) return res.status(500).json({error})
            else if (!updatedActive) res.status(400).json({error: 'user was not active'})
            else res.status(200).json(updatedActive)
        })
    }
});

router.post('/location', (req, res) => {
    if(typeof req.body.latitude !== "number" 
        || typeof req.body.longitude !== "number") {
            res.status(400).json({error: 'define longitude and latitude'})
    }
    else{
        let time
        if(typeof req.body.time !== 'undefined') time = req.body.time
        else time = Date()
        newLocation = Location({
            object: req.user,
            longitude: req.body.longitude,
            latitude: req.body.latitude,
            time: time
        })
        newLocation.save()
            .then(user => {
                res.status(200).send()
            })
            .catch(error => {
                res.status(500).json(error)
            })
    }
});

router.put('/:id', (req, res) => {
    if(typeof req.body.restaurant !== 'undefined') {
        User.findOneAndUpdate({_id: req.params.id}, {restaurant: req.body.restaurant}, {new: true}, (error, updatedUser) => {
            if (error) return res.status(500).json({error})
            else if (!updatedUser) res.status(404).json({error: 'user not found'})
            else res.status(200).json(updatedUser)
        })
    }
    if(typeof req.body.privilege !== 'undefined') {
        User.findOne({_id: req.user})
            .then(operatingUser => {
                if (operatingUser.privilege == true){
                    User.findOneAndUpdate({_id: req.params.id}, {privilege: req.body.privilege}, {new: true}, (error, updatedUser) => {
                        if (error) return res.status(500).json({error})
                        else if (!updatedUser) res.status(404).json({error: 'user not found'})
                        else res.status(200).json(updatedUser)
                })}
                else res.status(423).json({error: 'user is not allowed to do this action'})
            })
    }
    else res.status(204).send()
});

module.exports = router