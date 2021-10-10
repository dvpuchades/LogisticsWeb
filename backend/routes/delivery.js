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

router.put('/:id', (req, res) => {
    if (typeof req.body.dealer !== 'undefined') {
        Delivery.findOneAndUpdate({_id: req.params.id}, {name: req.body.name}, {new: true}, (error, updatedDelivery) => {
            if (error) return res.status(500).json({error})
            else if (!updatedDelivery) res.status(404).json({error: 'delivery not found'})
            else res.status(200).json(updatedDelivery)
        })
    }
    else if (typeof req.body.finished !== 'undefined') {
        if (req.body.finished) {
            Delivery.findOneAndUpdate({_id: req.params.id}, {finishTime: Date()}, {new: true}, (error, updatedDelivery) => {
                if (error) return res.status(500).json({error})
                else if (!updatedDelivery) res.status(404).json({error: 'delivery not found'})
                else res.status(200).json(updatedDelivery)
            })
        }
        else {
            Delivery.findOneAndUpdate({_id: req.params.id}, {finishTime: null}, {new: true}, (error, updatedDelivery) => {
                if (error) return res.status(500).json({error})
                else if (!updatedDelivery) res.status(404).json({error: 'delivery not found'})
                else res.status(200).json(updatedDelivery)
            })
        }
    }
    else res.status(400).json({error: 'define valid parameters'})
});

router.delete('/:id', (req, res) => {
    Delivery.deleteOne({_id: req.params.id}, (error, result) => {
        if (!result) res.status(404).json({error: 'delivery not found'}) 
        else if(error) res.status(500).json(error)
        else res.status(200).send()
    })
});

module.exports = router