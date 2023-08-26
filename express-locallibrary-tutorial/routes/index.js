var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Expresssssss' });
});

module.exports = router;

//Import the mongoose module
var mongoose = require("mongoose");

//Set up default mongoose connection
var mongoDB = "mongodb://127.0.0.1/my_database";
mongoose.connect(mongoDB);
// Get Mongoose to use the global promise library
mongoose.Promise = global.Promise;
//Get the default connection
var db = mongoose.connection;

//Bind connection to error event (to get notification of connection errors)
db.on("error", console.error.bind(console, "MongoDB connection error:"));

// Define schema
var Schema = mongoose.Schema;

var SomeModelSchema = new Schema({
  a_string: String,
  a_date: Date,
});

// Compile model from schema
var SomeModel = mongoose.model("SomeModel", SomeModelSchema);

