const mongoose = require('mongoose')

const model = mongoose.Schema({
    user: {
        type: mongoose.ObjectId,
        required: true
    },
    initTime: {
        type: Date,
        required: true
    },
    finishTime: {
        type: Date,
        required: false
    }
});

module.exports = new mongoose.model("Active", model)