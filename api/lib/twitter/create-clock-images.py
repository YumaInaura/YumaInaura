# https://qiita.com/agajo/items/90a29627e7c9a06ec24a

from PIL import Image, ImageDraw, ImageFont
import io
import re
import base64

# base64化された画像データを用意
data = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
# 頭のいらない部分を取り除いた上で、バイト列にエンコード
image_data_bytes = re.sub('^data:image/.+;base64,','',data).encode('utf-8')
# バイト列をbase64としてデコード
image_data = base64.b64decode(image_data_bytes)#返り値もバイト列
# ファイルとして開き、pillowのImageインスタンスにする
im2 = Image.open(io.BytesIO(image_data))


im = Image.new("RGB",(300,300),"blue")
im.paste(im2,(30,30))#画像に画像を重ねます。二つ目の引数は位置の指定。
draw = ImageDraw.Draw(im)
fnt = ImageFont.truetype('./Kokoro.otf',30)
draw.text((0,0),"日本語の\n文字だよ",font=fnt)
im.save("./test.png")

