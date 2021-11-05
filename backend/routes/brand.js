const express = require('express')
const router = express.Router()

const Brand = require('../models/brand')
const User = require('../models/user')

router.post('/', (req, res) => {
    Brand.findOne({ name: req.body.name }, (err, brand) => {
        if (err) {
            res.status(500).json({err})
        } else if (brand) {
            res.status(400).json({error:'Brand already exists'})
        } else {
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
        }
    })
});

router.get('/search/:pattern', (req, res) => {
    Brand.find({name: {$regex: req.params.pattern, $options: 'i'}})
        .then(brands => {
            if(!brands) res.status(404).json({ error: 'brands not found' })
            else {
                showableBrands = []
                processedBrands = 0
                brands.forEach(brand => {
                    showableBrands.push(brand.name)
                    processedBrands++
                })
                if (processedBrands == brands.length) res.status(200).json(showableBrands)
            }
        })
});

module.exports = router