require_relative "./class.rb"
str="test"
o=Weblio::GetWordData.new(str)
#get_data_lv:rdl:語彙レベル,Hash
#'{"レベル"=>"1", "英検"=>"3級以上の単語",...}'

#p o.rdl

#lookup_a:lu_a:語彙の意味,Array
#'[" (能力などをためす)試験", "検査", "(ものの)検査",...]'

#p o.lu_a

#lookup_h:lu_h:単語key,意味value,Hash
#'{"test"=>[" (能力などをためす)試験", "検査",...]}'

#p o.lookup_h

#level:lv:単語のレベル4つをHashに当てはめる。存在しない値はnil
# {
#    "レベル"=>"1"
#    "英検"=>"3級以上の単語", 
#    "学校レベル"=>"中学以上の水準", 
#    "TOEIC® LRスコア"=>"220点以上の単語"
# }

#p o.level

#au:audiouri:単語mp3のデータURI取得:String

p o.getAudio

