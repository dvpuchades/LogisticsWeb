const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Location = require('../models/location')
const Active = require('../models/active')
const buffer = require('../util/buffer')

router.post('/', (req, res) => {
    if(typeof req.body.latitude !== "number" 
        || typeof req.body.longitude !== "number") {
            res.status(400).json({error: 'define longitude and latitude'})
    }
    else{
        let locationUpdated = false
        let userUpdated = false
        const location = {
            object: req.user,
            longitude: req.body.longitude,
            latitude: req.body.latitude,
            time: Date()
        }
        newLocation = Location(location)

        buffer.set(req.user, location, 'updated', 'location')

        newLocation.save()
            .then(user => {
                locationUpdated = true
            })
            .catch(error => {
                res.status(500).json(error)
            })
        User.findOneAndUpdate({_id: req.user._id}, 
            {longitude: req.body.longitude, latitude: req.body.latitude, time: Date()},
            {new: true}, (error, updatedUser) => {
                if (error) return res.status(500).json({error})
                else if (!updatedUser) res.status(404).json({error: 'user not found'})
                else userUpdated = true
        })
        if(locationUpdated && userUpdated) res.status(200).send()
    }
});

router.get('/restaurant/:idRestaurant', (req, res) => {
    getLocationForActiveUsersInRestaurant(req, res)
});

function getLocationForActiveUsersInRestaurant(req, res) {
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
                    if (processedUsers == users.length) getLocationForActiveUsers(req, res, showableUsers)
                })
            } 
        })
}

function getLocationForActiveUsers(req, res, users){
    availableUsers = []
    let processedUsers = 0
    users.forEach(user => {
        Active.find({user: user._id, finishTime: { $exists: false }})
            .then(active => {
                if (active.length == 1) availableUsers.push(user)
                processedUsers++
                if (processedUsers == users.length) getLocationFromUserList(req, res, availableUsers)
            })
    })
}

function getLocationFromUserList(req, res, users){
    let locatedUsers = []
    let processedUsers = 0
    users.forEach(user => {
        Location.findOne({ object: user._id}).sort({time: 'descending'})
            .then(location => {
                if (location) {
                    user.location = {
                        longitude: location.longitude,
                        latitude: location.latitude,
                        time: location.time
                    }
                    locatedUsers.push(user)
                }
                processedUsers++
                if (processedUsers == users.length) res.status(200).json(locatedUsers)
            })
    })
}

router.get('/user/:id', (req, res) => {
    Location.findOne({ object: req.params.id }).sort({time: 'descending'})
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