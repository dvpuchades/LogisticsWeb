const jwt = require('jsonwebtoken')
const tokenSecret = 'something'

const User = require('../models/user')

// exports.verify = (req, res, next) => {
//     const token = req.headers.authorization
//     if (!token) res.status(403).json({error: "please provide a token"})
//     else {
//         jwt.verify(token, tokenSecret, (err, value) => {
//             if (err) res.status(500).json({error: 'failed to authenticate token'})
//             req.user = value.data
//             next()
//         })
//     }
// }

//  temporal solution before integrating user cache
exports.verify = (req, res, next) => {
    const token = req.headers.authorization
    if (!token) res.status(403).json({error: "please provide a token"})
    else {
        jwt.verify(token, tokenSecret, (err, value) => {
            if (err) res.status(500).json({error: 'failed to authenticate token'})
            User.findOne({_id: value.data._id}, (err, user) => {
                if (err) res.status(500).json({error: 'failed to get user from database'})
                req.user = user
                next()
            })
        })
    }
}