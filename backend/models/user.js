const mongoose = require('mongoose')

const model = mongoose.Schema({
    name: {
        type: String,
        required: false
    },
    email: {
        type: String,
        required: true
    },
    phone: {
        type: String,
        required: false
    },
    password: {
        type: String,
        required: true
    },
    brand: {
        type: mongoose.ObjectId,
        required: false
    },
    restaurant: {
        type: mongoose.ObjectId,
        required: false
    },
    privilege: {
        type: Boolean,
        required: false
    }
});

module.exports = new mongoose.model("User", model)