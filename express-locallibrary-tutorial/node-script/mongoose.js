
// https://mongoosejs.com/docs/index.html

const mongoose = require('mongoose')

main().catch(err => console.log(err))

async function main() {
  await mongoose.connect('mongodb://127.0.0.1:27017/test')

  // スキーマの定義
  const kittySchema = new mongoose.Schema({
    name: String
  })

  // モデルにスキーマをコンパイルする (らしい)
  const Kitten = mongoose.model('Kitten', kittySchema)

  // DBに保存する
  const fluffy = new Kitten({ name: 'fluffy' })
  await fluffy.save()

  console.log('SAVE')

  // 特定のnameのデータを取得する
  // DBへの保存なのでスクリプトを起動するたびにデータが増える
  const kittens = await Kitten.find({ name: /^fluff/ });

  // 表示例
  // [
  //   {
  //     _id: new ObjectId("64e9f4bb6576f87bdc838c0e"),
  //     name: 'fluffy',
  //     __v: 0
  //   },
  //   {
  //     _id: new ObjectId("64e9f4c7e16502c2c740eb72"),
  //     name: 'fluffy',
  //     __v: 0
  //   }
  // ]
  console.log(kittens)

}
