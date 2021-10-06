const express = require('express')
const router = express.Router()
const User = require('../models/user')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const tokenSecret = 'something'

router.get('/login', (req, res) => {
    User.findOne({email: req.body.email})
        .then(user => {
            if (!user) res.status(404).json({error: 'not user found'})
            else {
                bcrypt.compare(req.body.password, user.password, (error, match) => {
                    if (error) res.status(500).json(error)
                    else if (match) res.status(200).json({token: generateToken(user)})
                    else res.status(403).json({error: 'wrong password'})
                })
            } 
        })
        .catch(error => {
            res.status(500).json(error)
        })
});

router.post('/signup', (req, res) => {
    const rounds = 10
    bcrypt.hash(req.body.password, rounds, (error, hash) => {
        // TODO: check if user is signed up
        if(error) res.status(500).json(error)
        else {
            const newUser = User({email: req.body.email, password: hash})
            newUser.save()
                .then(user => {
                    res.status(200).json({token: generateToken(user)})
                })
                .catch(error => {
                    res.status(500).json(error)
                })
        }
    })
});

function generateToken(user){
    return jwt.sign({data: user}, tokenSecret, {expiresIn: '7 days'})
}

module.exports = router