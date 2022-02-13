const express = require('express')
const router = express.Router()

const Restaurant = require('../models/restaurant')
const User = require('../models/user');
const buffer = require('../util/buffer');

router.post('/', (req, res) => {
    if (req.user.privilege) {
        const restaurant = {
            name: req.body.name,
            address: req.body.address,
            brand: req.user.brand,
            createdBy: req.user._id,
            creationDate: Date()
        }
        const newRestaurant = Restaurant(restaurant)
        buffer.set(req.user, restaurant, 'new', 'restaurant')
        newRestaurant.save()
            .then(restaurant => {
                res.status(200).send()
            })
            .catch(error => {
                res.status(500).json(error)
            })
    }
    else {
        res.status(423).json({error: 'user is not allowed to do this action'})
    }
});

router.get('/', (req, res) => {
    Restaurant.find({brand: req.user.brand})
        .then(restaurants => {
            if(!restaurants) res.status(404).json({ error: 'restaurants not found' })
            else res.status(200).json(restaurants)
        })
});

router.put('/:id', (req, res) => {
    let updates = {}
    if (typeof req.body.name !== 'undefined') updates.name = req.body.name;
    if (typeof req.body.address !== 'undefined') updates.address = req.body.address;
    if (updates !== {}) {
        if (req.user.privilege) {
            Restaurant.findOneAndUpdate({_id: req.params.id}, {name: req.body.name}, {new: true}, (error, updatedRestaurant) => {
                if (error)  res.status(500).json({error})
                else if (!updatedRestaurant) res.status(404).json({error: 'restaurant not found'})
                else {
                    buffer.set(req.user, updatedRestaurant, 'update', 'restaurant')
                    res.status(200).json(updatedRestaurant)
                }
            })
        }
        else{
            res.status(423).json({error: 'user is not allowed to do this action'})
        }
    }
    else res.status(400).json({error: 'parameters needed'})
});

router.delete('/:id', (req, res) => {
    if (user.privilege == true) {
        Restaurant.deleteOne({_id: req.params.id}, (error, result) => {
            if (!result) res.status(404).json({error: 'restaurant not found'}) 
            else if(error) res.status(500).json(error)
            else {
                buffer.set(req.user, {_id: req.params.id}, 'delete', 'restaurant')
                res.status(200).send()
            }
        })
    }
    else{
        res.status(423).json({error: 'user is not allowed to do this action'})
    }
});

module.exports = router