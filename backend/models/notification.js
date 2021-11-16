const mongoose = require('mongoose')

const model = mongoose.Schema({
    type: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: false
    },
    from: {
        type: mongoose.ObjectId,
        required: true
    },
    to: {
        type: mongoose.ObjectId,
        required: true
    },
    creationDate: {
        type: Date,
        required: true
    }
});

module.exports = new mongoose.model("Notification", model)