const mongoose = require('mongoose')
//var mongoose_delete = require('mongoose-delete');

const model = mongoose.Schema({
    uploadUser: {
        type: mongoose.ObjectId,
        required: true,
    },
    restaurant: {
        type: mongoose.ObjectId,
        required: true
    },
    brand: {
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

//model.plugin(mongoose_delete);
module.exports = new mongoose.model("Delivery", model)