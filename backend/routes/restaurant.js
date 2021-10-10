const express = require('express')
const router = express.Router()

const Restaurant = require('../models/restaurant')
const User = require('../models/user')

router.post('/', (req, res) => {
    User.findOne({_id: req.user})
        .then(user => {
            if (user.privilege == true) {
                const newRestaurant = Restaurant({
                    name: req.body.name,
                    brand: user.brand,
                    createdBy: req.user,
                    creationDate: Date()
                })
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
        })
});

router.delete('/restaurant/:id', (req, res) => {
    User.findOne({_id: req.user})
        .then(user => {
            if (user.privilege == true) {
                Restaurant.deleteOne({_id: req.params.id}, (error, result) => {
                    if (!result) res.status(404).json({error: 'restaurant not found'}) 
                    else if(error) res.status(500).json(error)
                    else res.status(200).send()
                })
            }
            else{
                res.status(423).json({error: 'user is not allowed to do this action'})
            }
        })
});

module.exports = router