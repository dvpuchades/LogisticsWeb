const express = require("express")
const mongoose = require("mongoose")
const app = express()

const authRoute = require('./routes/auth')
const routes = require('./routes/routes')

const  dbURI = "mongodb://localhost/authentication"
app.use(express.json())
app.use('/api/auth', authRoute)
app.use('/api', routes)

mongoose.connect(dbURI , {useNewUrlParser: true, useUnifiedTopology: true})
const db = mongoose.connection

db.on("error", (err)=>{console.error(err)})
db.once("open", () => {console.log("DB started successfully")})

// TODO

app.listen(2400, () => {console.log("Server started: 2400")})