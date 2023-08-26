const mongoose = require('mongoose')

// https://mongoosejs.com/docs/index.html


mongoose.connect('mongodb://127.0.0.1:27017/test')

// スキーマの定義
const kittySchema = new mongoose.Schema({
  name: String
})

// モデルにスキーマをコンパイルする (らしい)
const Kitten = mongoose.model('Kitten', kittySchema)

// DBに保存する
const fluffy = new Kitten({ name: 'fluffy' })
fluffy.save()

// 特定のnameのデータを取得する
// DBへの保存なのでスクリプトを起動するたびにデータが増える
const kittens = Kitten.find({ name: /^fluff/ });

var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: `Expresssssss` });
});

module.exports = router;
