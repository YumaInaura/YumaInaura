File.write('tmp/sjis.csv', "あ,い,う\nえ,お,か", encoding: Encoding::SJIS)
#  => 17

File.read('tmp/sjis.csv', encoding: Encoding::SJIS)
# => "あ,い,う\nえ,お,か"

CSV.read('tmp/sjis.csv', encoding: Encoding::SJIS)
# => [["あ", "い", "う"], ["え", "お", "か"]]


CSV.open('tmp/sjis2.csv', 'w', encoding: Encoding::SJIS) do |row|
  row << ['か', 'き', 'く']
  row << ['け', 'こ', 'さ']
end
# => <#CSV io_type:File io_path:"tmp/sjis2.csv" encoding:UTF-8 lineno:2 col_sep:"," row_sep:"\n" quote_char:"\"">

File.read('tmp/sjis2.csv', encoding: Encoding::SJIS)
# => "か,き,く\nけ,こ,さ\n"

CSV.read('tmp/sjis2.csv', encoding: Encoding::SJIS)
# => [["か", "き", "く"], ["け", "こ", "さ"]]
