const express = require('express')
const router = express.Router()

const Brand = require('../models/brand')
const User = require('../models/user')

router.post('/', (req, res) => {
    const newBrand = Brand({
        name: req.body.name,
        createdBy: req.user,
        creationDate: Date()
    })
    newBrand.save()
        .then(brand => {
            User.findOneAndUpdate({_id: req.user._id}, {privilege: true, brand: brand._id}, {new: true})
                .then(user => {
                    if (!user) res.status(500).json({error: 'user does not exist'})
                })
                .catch(error => res.status(500).json(error))
            res.status(200).send()
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

module.exports = router