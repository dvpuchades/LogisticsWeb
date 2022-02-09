const express = require('express')
const router = express.Router()

const Delivery = require('../models/delivery')
const Context = require('../util/context')

router.post('/', (req, res) => {
    const newDelivery = Delivery({
        uploadUser: req.user._id, 
        restaurant: req.body.restaurant,
        brand: req.user.brand,
        dealer: req.body.dealer, 
        address: req.body.address,
        city: req.body.city,
        postcode: req.body.postcode, 
        initTime: Date(),
        finishTime: req.body.finishTime,
        amount: req.body.amount,
        customer: req.body.customer,
        phone: req.body.phone
    })

    let key
    if(typeof req.user.restaurant == 'undefined'){
        key = req.user.brand.toString()
    }else{
        key = req.user.brand.toString() + req.user.restaurant.toString()
    }
    Context.set(key, {content: newDelivery, index: Date.now()})

    newDelivery.save()
        .then(Delivery => {
            res.status(200).send()
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/', (req, res) => {
    Delivery.find({brand: req.user.brand})
        .then(deliveries => {
            if(!deliveries) res.status(404).json({error: 'not delivery found'})
            else res.status(200).json(deliveries)
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.get('/:restaurantId', (req, res) => {
    Delivery.find({restaurant: req.body.restaurantId})
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
    if(req.user.privilege){
        Delivery.deleteOne({_id: req.params.id}, (error, result) => {
            if (!result) res.status(404).json({error: 'delivery not found'}) 
            else if(error) res.status(500).json(error)
            else res.status(200).send()
        })
    }
    else res.status(403).json({error: 'only privilege users can delete deliveries'})
});

module.exports = router