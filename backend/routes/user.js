const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Active = require('../models/active')

router.get('/', (req, res) => {
    User.find({brand: req.user.brand})
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

router.get('/active', (req, res) => {
    let showableUsers = []
    Active.find({finishTime: null})
        .then( actives => {
            if(!actives) res.status(404).json({error: 'not active users'})
            actives.forEach(active => {
                User.findOne({_id: active.user})
                    .then(user => {
                        showableUsers.push({
                            name: user.name,
                            email: user.email,
                            phone: user.phone
                        })
                    })
                res.status(200).json(showableUsers)
            })
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.put('/:id', (req, res) => {
    if(typeof req.body.privilege !== 'undefined') {
        User.findOne({_id: req.user})
            .then(operatingUser => {
                if (operatingUser.privilege == true){
                    console.log(req.body.privilege)
                    User.findOneAndUpdate({_id: req.params.id}, {privilege: req.body.privilege}, {new: true}, (error, updatedUser) => {
                        if (error) return res.status(500).json({error})
                        else if (!updatedUser) res.status(404).json({error: 'user not found'})
                        else res.status(200).json(updatedUser)
                })}
                else res.status(423).json({error: 'user is not allowed to do this action'})
            })
    }
    else res.status(204).send()
});

module.exports = router