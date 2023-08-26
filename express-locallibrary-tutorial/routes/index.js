const mongoose = require('mongoose')

// https://mongoosejs.com/docs/index.html


mongoose.connect('mongodb://127.0.0.1:27017/test')

// スキーマの定義
const kittySchema = new mongoose.Schema({
  name: String
})

const Kitten = mongoose.model('Kitten', kittySchema)

var express = require('express')
var router = express.Router()


const kittens = Kitten.find({ name: /^fluff/ })

router.get('/', function(req, res, next) {
  // DBに保存する
  const fluffy = new Kitten({ name: 'fluffy' })
  fluffy.save()

  console.log(kittens)

 res.render('index', { title: `Expresssssss ${kittens}` })
})

module.exports = router
