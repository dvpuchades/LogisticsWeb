const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Location = require('../models/location')

router.post('/', (req, res) => {
    if(typeof req.body.latitude !== "number" 
        || typeof req.body.longitude !== "number") {
            res.status(400).json({error: 'define longitude and latitude'})
    }
    else{
        newLocation = Location({
            object: req.user,
            longitude: req.body.longitude,
            latitude: req.body.latitude,
            time: Date()
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

router.get('/restaurant/:idRestaurant', (req, res) => {
    let showableUsers = []
    User.find({restaurant: req.params.idRestaurant})
        .then( users => {
            if(!users) {
                res.status(404).json({error: 'not users'})
                return
            }
            users.forEach(user => {
                Active.find({user: user._id, finishTime: { $exists: false }})
                    .then(active => {
                        console.log(active)
                        if (active) {
                            Location.findOne({}, {}, { object: user._id, sort: { 'time' : -1 } })
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
                    .catch(error => {
                        res.status(500).json(error)
                    })
            })
            if(showableUsers == []) res.status(404).json({error: 'not active users'})
            else res.status(200).json(showableUsers)
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

/**
 * get users
 * check if is active
 * get location
 * send showableUsers
 */

function getUsers(req, res, next) {
    let showableUsers = []
    User.find({restaurant: req.params.idRestaurant})
        .then( users => {
            if (!users) res.status(404).json({error: 'not user found'})
            else {
                let showableUsers = []
                let processedUsers = 0
                users.forEach(user => {
                    showableUsers.push({
                        _id: user._id,
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        restaurant: user.restaurant
                    })
                    processedUsers++
                    if (processedUsers == users.length) next(showableUsers)
                })
            } 
        })
}

function checkUsersActive(users, next){
    availableUsers = []
    let processedUsers = 0
    users.forEach(user => {
        Active.find({user: user._id, finishTime: { $exists: false }})
            .then(active => {
                if (active) availableUsers.push(user)
            })
        processedUsers++
        if (processedUsers == users.length) next(availableUsers)
    })
}

// HERE

router.get('/:id', (req, res) => {
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

module.exports = router