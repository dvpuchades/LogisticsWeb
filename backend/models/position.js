const mongoose = require('mongoose')

const model = mongoose.Schema({
    object: {
        type: mongoose.ObjectId,
        required: true
    },
    latitude: {
        type: Number,
        required: true
    },
    longitude: {
        type: Number,
        required: true
    },
    time: {
        type: Date,
        required: true
    }
});

module.exports = new mongoose.model("Position", model)