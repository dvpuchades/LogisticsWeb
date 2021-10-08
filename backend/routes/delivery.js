const express = require('express')
const router = express.Router()

const Delivery = require('../models/delivery')

router.post('/', (req, res) => {
    
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

router.get('/', (req, res) => {
    Delivery.find({})
        .then(deliveries => {
            if(!deliveries) res.status(404).json({error: 'not delivery found'})
            else res.status(200).json(deliveries)
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/:restaurantId', (req, res) => {
    Delivery.find({restaurant: req.body.restaurant})
        .then(deliveries => {
            if(!deliveries) res.status(404).json({error: 'not delivery found'})
            else res.status(200).json(deliveries)
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.delete('/:id', (req, res) => {
    Delivery.deleteOne({_id: req.params.id}, (error, result) => {
        if (!result) res.status(404).json({error: 'delivery not found'}) 
        else if(error) res.status(500).json(error)
        else res.status(200).send()
    })
});

module.exports = router