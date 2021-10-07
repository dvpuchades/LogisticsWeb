const mongoose = require('mongoose')

const model = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    brand: {
        type: mongoose.ObjectId,
        required: true
    }
});

module.exports = new mongoose.model("Restaurant", model)