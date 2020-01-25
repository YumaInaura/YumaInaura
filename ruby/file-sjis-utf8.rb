
# -----------------------------------------------------------
# String のエンコード
# -----------------------------------------------------------

# 日本語を文字列としてエンコードした結果
'あ'.encode(Encoding::SJIS)
# => "\x{82A0}"

# String的にUTf_8にエンコードし直すと、UTf_8に戻る
"あ".encode(Encoding::SJIS).encode(Encoding::UTF_8)
# => "あ"

# -----------------------------------------------------------
# A. UTF8の文字列を UTF_8指定で ファイルに書き込む
# -----------------------------------------------------------
File.write('tmp/utf8.txt', 'あ', encoding: Encoding::UTF_8)
# => 3

# 当たり前だがUTF_8で読める
File.read('tmp/utf8.txt', encoding: Encoding::UTF_8)
# => "あ"

# SJIS では読めない
File.read('tmp/utf8.txt', encoding: Encoding::SJIS)
# Encoding::InvalidByteSequenceError: incomplete "\x82" on Windows-31J

# -----------------------------------------------------------
# B. SJIS にエンコードした文字列を UTF_8指定で ファイルに書き込む
# -----------------------------------------------------------
File.write('tmp/sjis_string.txt', 'あ'.encode(Encoding::SJIS), encoding: Encoding::UTF_8)
# => 3

# なぜかUTF_8で読める
File.read('tmp/sjis_string.txt', encoding: Encoding::UTF_8)
# => "あ"

# SJIS では読めない
File.read('tmp/sjis_string.txt', encoding: Encoding::SJIS)
# Encoding::InvalidByteSequenceError: incomplete "\x82" on Windows-31J

# 文字列のStringでんエンコードは無視されて、Aパターンと全く同じ挙動になっているような気がした
# File.write がエンコード関係をすべてうまくハンドリングしてくれているのかもしれない

# -----------------------------------------------------------
# UTF_8の文字列を SJIS指定でファイルに書き込む
# -----------------------------------------------------------
File.write('tmp/sjis_encoding.txt', 'あ', encoding: Encoding::SJIS)
# => 2

# UTF8で読むとこのような文字列が返る
File.read('tmp/sjis_encoding.txt', encoding: Encoding::UTF_8)
# => "\x82\xA0"

# 文字列自体をUTF_8エンコードしても何も変わらない
# 何か自分がエンコードやデコードの関係を根本的に理解していない気はする
File.read('tmp/sjis_encoding.txt', encoding: Encoding::UTF_8).encode(Encoding::UTF_8)
# => "\x82\xA0"

# SJIS指定をしてファイルを読んだ時にUTF_8の文字列が返る
File.read('tmp/sjis_encoding.txt', encoding: Encoding::SJIS)
# => "あ"

