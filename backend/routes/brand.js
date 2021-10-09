const express = require('express')
const router = express.Router()

const Brand = require('../models/brand')

router.post('/', (req, res) => {
    const newBrand = Brand({
        name: req.body.name,
        createdBy: req.user,
        creationDate: Date()
    })

    newBrand.save()
        .then(user => {
            res.status(200).send()
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

module.exports = router