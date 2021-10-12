const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Active = require('../models/active')
const Location = require('../models/location')

const bcrypt = require('bcrypt')

const rounds = 10

router.get('/', (req, res) => {
    User.find({brand: req.user.brand})
        .then(users => {
            if (!users) res.status(404).json({error: 'not user found'})
            else {
                let showableUsers = []
                users.forEach(user => {
                    showableUsers.push({
                        _id: user._id,
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

router.put('/info', (req, res) => {
    let updates = {}
    if (req.body.phone) updates.phone = req.body.phone
    if (req.body.password) {
        bcrypt.hash(req.body.password, rounds, (error, hash) => {
            if(error) {
                res.status(500).json(error)
                return
            }
            else updates.password = hash
        })
    }
    if (req.body.brand) updates.brand = req.body.brand
    if (req.body.restaurant) updates.restaurant = req.body.restaurant
    if (updates !== {}) {
        User.findOneAndUpdate({_id: req.user._id}, updates, {new: true}, (error, updatedUser) => {
            if (error) return res.status(500).json({error})
            else if (!updatedUser) res.status(404).json({error: 'user not found'})
            else res.status(200).send()
        })
    }
    else res.status(400).json({error: 'parameters needed'})
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

router.get('/location/:id', (req, res) => {
    Location.findOne({ object: req.params.id, sort: { 'time' : -1 } })
        .then(location => {
            if (!location) res.status(404).json({error: 'location not found'})
            else{
                res.status(200).json(location)
            }
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/location/:idRestaurant', (req, res) => {
    let showableUsers = []
    User.find({restaurant: req.params.idRestaurant})
        .then( users => {
            if(!users) res.status(404).json({error: 'not users'})
            users.forEach(user => {
                Active.findOne({user: user._id, finishTime: null})
                    .then(active => {
                        if (active) {
                            Location.findOne({}, {}, { object: req.params.id, sort: { 'created_at' : -1 } })
                                .then(location => {
                                    if (!location){
                                        showableUsers.push({
                                            name: user.name,
                                            email: user.email,
                                            phone: user.phone,
                                        })
                                    }
                                    else{
                                        showableUsers.push({
                                            name: user.name,
                                            email: user.email,
                                            phone: user.phone,
                                            location: {
                                                longitude: location.longitude,
                                                latitude: location.latitude,
                                                time: location.time
                                            }
                                        })
                                    }
                                })
                                .catch(error => {
                                    res.status(500).json(error)
                                })
                        }
                    })
            })
            if(showableUsers == []) res.status(404).json({error: 'not active users'})
            else res.status(200).json(showableUsers)
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.put('/:id', (req, res) => {
    if(req.user.privilege) {
        let updates = {}
        if(typeof req.body.restaurant !== 'undefined') updates.restaurant = req.body.restaurant
        if(typeof req.body.privilege !== 'undefined') updates.privilege = req.body.privilege
        if(updates !== {}){
            User.findOneAndUpdate({_id: req.params.id}, {restaurant: req.body.restaurant}, {new: true}, (error, updatedUser) => {
                if (error) return res.status(500).json({error})
                else if (!updatedUser) res.status(404).json({error: 'user not found'})
                else res.status(200).json(updatedUser)
            })
        }
        else res.status(400).json({error: 'parameters needed'})
    }
    else res.status(423).json({error: 'user is not allowed to do this action'})
});

module.exports = router