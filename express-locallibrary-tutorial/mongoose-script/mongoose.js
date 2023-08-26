
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

  // 特定の条件式でデータを取得する
  // DBへの保存なのでこのスクリプトを起動するたびにデータが増える

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
  const kittens = await Kitten.find({ name: /^fluff/ });
  console.log(kittens)

  // レコード個数を表示
  const count = await Kitten.count()
  console.log(count)
}
