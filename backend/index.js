const express = require('express')
const mongoose = require('mongoose')
const app = express()
const cors = require('cors');

const authRoute = require('./routes/auth')
const deliveryRoute = require('./routes/delivery')
const locationRoute = require('./routes/location')
const userRoute = require('./routes/user')
const activeRoute = require('./routes/active')
const brandRoute = require('./routes/brand')
const restaurantRoute = require('./routes/restaurant')
const contextRoute = require('./routes/context')

const middleware = require('./middleware')
app.use(cors({
    origin: '*'
}));

const  dbURI = "mongodb://localhost/fattorino"
app.use(express.json())
app.use('/api/auth', authRoute)

app.use(middleware.verify)

app.use('/api/delivery', deliveryRoute)
app.use('/api/location', locationRoute)
app.use('/api/user/active', activeRoute)
app.use('/api/user', userRoute)
app.use('/api/restaurant', restaurantRoute)
app.use('/api/brand', brandRoute)
app.use('/api/context', contextRoute)

mongoose.connect(dbURI , {useNewUrlParser: true, useUnifiedTopology: true})
const db = mongoose.connection

db.on("error", (err)=>{console.error(err)})
db.once("open", () => {console.log("DB started successfully")})

app.set('contextMap', new Map())
// TODO

app.listen(2400, () => {console.log("Server started: 2400")})