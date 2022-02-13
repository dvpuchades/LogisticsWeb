const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Active = require('../models/active')

const bcrypt = require('bcrypt')
const buffer = require('../util/buffer')

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
            else {
                res.status(200).send()
                updates.password = ''
                buffer.set(req.user, updates, 'update', 'user')
            }
        })
    }
    else res.status(400).json({error: 'parameters needed'})
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
                else {
                    buffer.set(req.user, updates, 'update', 'user')
                    res.status(200).json(updatedUser)
                }
            })
        }
        else res.status(400).json({error: 'parameters needed'})
    }
    else res.status(423).json({error: 'user is not allowed to do this action'})
});

module.exports = router