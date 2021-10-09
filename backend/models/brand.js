const mongoose = require('mongoose')

const model = mongoose.Schema({
    name: {
        type: String,
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

module.exports = new mongoose.model("Brand", model)