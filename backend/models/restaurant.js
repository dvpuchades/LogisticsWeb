const mongoose = require('mongoose')

const model = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: false
    },
    city: {
        type: String,
        required: false
    },
    postcode: {
        type: String,
        required: false
    },
    latitude: {
        type: Number,
        required: false
    },
    longitude: {
        type: Number,
        required: false
    },
    brand: {
        type: mongoose.ObjectId,
        required: true
    },
    createdBy: {
        type: mongoose.ObjectId,
        required: true
    },
    creationDate: {
        type: Date,
        required: true
    }
});

module.exports = new mongoose.model("Restaurant", model)