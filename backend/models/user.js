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
        type: Number,
        required: false
    },
    password: {
        type: String,
        required: true
    },
    brand: {
        type: mongoose.ObjectId,
        required: true
    },
    restaurant: {
        type: mongoose.ObjectId,
        required: false
    }
});

module.exports = new mongoose.model("User", model)