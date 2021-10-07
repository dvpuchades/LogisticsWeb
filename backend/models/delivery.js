const mongoose = require('mongoose')

const model = mongoose.Schema({
    uploadUser: {
        type: mongoose.ObjectId,
        required: true,
    },
    restaurant: {
        type: mongoose.ObjectId,
        required: true
    },
    dealer: {
        type: mongoose.ObjectId,
        required: false
    },


    address: {
        type: String,
        required: true
    },
    postcode: {
        type: String,
        required: false
    },
    initTime: {
        type: Date,
        required: true
    },
    finishTime: {
        type: Date,
        required: false
    },
    amount: {
        type: Number,
        required: true
    },
    customer: {
        type: String,
        required: false
    }
});

module.exports = new mongoose.model("Delivery", model)