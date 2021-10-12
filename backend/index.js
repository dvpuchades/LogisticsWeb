const express = require("express")
const mongoose = require("mongoose")
const app = express()

const authRoute = require('./routes/auth')
const deliveryRoute = require('./routes/delivery')
const userRoute = require('./routes/user')
const activeRoute = require('./routes/active')
const brandRoute = require('./routes/brand')
const restaurantRoute = require('./routes/restaurant')

const middleware = require('./middleware')

const  dbURI = "mongodb://localhost/fattorino"
app.use(express.json())
app.use('/api/auth', authRoute)

app.use(middleware.verify)

app.use('/api/delivery', deliveryRoute)
app.use('/api/user/active', activeRoute)
app.use('/api/user', userRoute)
app.use('/api/restaurant', restaurantRoute)
app.use('/api/brand', brandRoute)

mongoose.connect(dbURI , {useNewUrlParser: true, useUnifiedTopology: true})
const db = mongoose.connection

db.on("error", (err)=>{console.error(err)})
db.once("open", () => {console.log("DB started successfully")})

// TODO

app.listen(2400, () => {console.log("Server started: 2400")})