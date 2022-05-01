const express = require('express');

const Active = require('../models/active')
const Notification = require('../models/notification');
const Restaurant = require('../models/restaurant')
const User = require('../models/user')
const Delivery = require('../models/delivery');

const router = express.Router()

const buffer = require('../util/buffer');
const delivery = require('../models/delivery');

router.get('/update/:index', (req, res) => {
    let index = Number.parseInt(req.params.index)
    let data = buffer.get(req.user, index)
    if(data.error == true){
        res.status(404).send()
    }else{
        res.status(200).json(data)
    }
});

router.get('/new', (req, res) => {
    let usersReady = false
    let userList = []
    let deliveryList
    let notificationList
    let restaurantList

    //get users
    Active.find({brand: req.user.brand, finishTime: { $exists: false }})
        .then( actives => {
            if(actives.length > 0) {
                let count = 0;
                actives.forEach(active => {
                    User.findOne({_id: active.user})
                        .then( user => {
                            userList.push({
                                id: user._id,
                                name: user.name,
                                email: user.email,
                                phone: user.phone,
                                restaurant: user.restaurant,
                                latitude: user.latitude,
                                longitude: user.longitude,
                                time: user.time
                            })
                        })
                    count++;
                });
                if(count == actives.length) {
                    usersReady = true
                }
            }
            else{
                usersReady = true
            }
        })
        .catch(error => {
            res.status(500).json(error)
        })
        .finally(sendData)

    //get deliveries
    Delivery.find({brand: req.user.brand})
        .then(deliveries => {
            if(!deliveries) { deliveryList = [] }
            else{ deliveryList = deliveries }
        })
        .catch(error => {
            res.status(500).json(error)
        })
        .finally(sendData)

    //get add requests
    if(req.user.privilege){
        Notification.find({brand: req.user.brand})
            .then(notifications => {
                if(!notifications){ notificationList = [] }
                else{ notificationList = notifications }
            })
            .catch(error => {
                res.status(500).json(error)
            })
            .finally(sendData)
    }else{
        notificationList = []
        sendData()
    }

    //get restaurants
    Restaurant.find({brand: req.user.brand})
        .then(restaurants => {
            if(!restaurants){ restaurantList = [] }
            else { restaurantList = restaurants }
        })
        .finally(sendData)

    //send data
    function sendData(){
        if(usersReady 
            && deliveryList 
            && notificationList 
            && restaurantList)
        {
            res.status(200).json({
                users: userList,
                deliveries: deliveryList,
                notifications: notificationList,
                restaurants: restaurantList
            })
        }
    }
});

module.exports = router