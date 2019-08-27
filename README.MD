# Weblio_scrape is...
This enable you to fetch from weblio data and scrape it. 

# DIRECTORIES
.  
├── class_calltest.rb  
├── class.rb  
├── data  
│   ├── lv.csv  
│   ├── lv_dictionary.csv  
│   ├── README.MD  
│   └── vocav.csv  
├── main.rb  
├── test_audio.mp3  
└── tool  
　├── interactive  
　│   ├── weblio_inf.rb  
　│   ├── weblio_look_n_lev.rb  
　│   ├── weblio_mp3.rb  
　│   └── weblio_rev.rb  
　└── weblio_stdin.rb  

# TOOLS
- weblio_inf.rb  
  - till `Ctrl+C` or `exit` , turn input word into jpn⇔eng one with meanings as an dictionary
- weblio_look_n_lev.rb  
  - turn input word into jpn⇔eng one with meanings and levels as an dictionary
- weblio_mp3.rb  
  - play word-pronounciation voice of input word (require: `ffmpeg`)
- weblio_rev.rb  
  - show input word's level only
- weblio_stdin.rb  
  - get your input as ARGV.
# EXAMPLE
```ruby
require_relative "./class.rb"

str="test"

o=Weblio::GetWordData.new(str)
#get_data_lv:rdl:語彙レベル,Hash
#'{"レベル"=>"1", "英検"=>"3級以上の単語",...}'

p o.rdl

#lookup_a:lu_a:語彙の意味,Array
#'[" (能力などをためす)試験", "検査", "(ものの)検査",...]'

p o.lu_a

#lookup_h:lu_h:単語key,意味value,Hash
#'{"test"=>[" (能力などをためす)試験", "検査",...]}'

p o.lookup_h

#level:lv:単語のレベル4つをHashに当てはめる。存在しない値はnil
# {
#    "レベル"=>"1"
#    "英検"=>"3級以上の単語", 
#    "学校レベル"=>"中学以上の水準", 
#    "TOEIC® LRスコア"=>"220点以上の単語"
# }

p o.level

#au:audiouri:単語mp3のデータURI取得:String

p o.getAudio
```
