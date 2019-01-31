#this program is required "ffplay"
#
## TODO:to make treatable: CSV wordlist, sentence->noun, level average by each kind
#
#...i hate test
Class Weblio
  require "uri";require "open-uri"

  def initialize(word)
    @word = word;end

  #internal
  def retrieve_data
    return open(URI.encode("https://ejje.weblio.jp/content/#{@word}")).read;end
    alias_method :rd, :retrieve_data


  def ret_data_lv
    return rd.scan(/learning-level-table-wrap(.*)語彙力テストを受ける/).flatten[0]
    .scan(/>(.*?)</).flatten.delete_if{|a|a==""}
    .map{|a|a.encode("UTF-8")}.join("/")
    .scan(/(.*?\/：\/.*?\/|.*?\/：\/.*?$)/);end
    alias_method :rdl, :ret_data_lv

  #look up meanings
  def lookup_s
    data=rd.mean.read.scan(/content=\"(.*)\"?>/).flatten
    return data[-1].include?(":") ? data[-1].gsub('"',"") : "*nope: いや,いいえ*";end
    alias_method :lu_s, :lookup_s


  def lookup_a
    return lookup_s.gsub(/: /,",").split(",");end
    alias_method :lu_a, :lookup_a


  def lookup_h
    return {:"#{(v = lookup_a).shift}" => v};end
    alias_method :lu_h, :lookup_h

  #level
  def level_s
    return rdl.join(", ").gsub(/&amp;|\//,"").gsub(/：/,":");end
    alias_method :lv_s, :level_s


  def level_a
    exist = {"レベル":nil,"英検":nil,"学校レベル":nil,"TOEIC® LRスコア":nil}
    level_s.split(", ").map{|a|a.split(":")}.map{|o,e|exist["#{o}"]=e}
    return exist.to_a;end
    alias_method :lv_a, :level_a


  def level_h
    return level_a.to_h;end
    alias_method :lv_h, :level_h

  #mp3 file of noun
  def retrieve_mp3
    return rd.scan(/https:\/\/.*?\.mp3/)[0];end
    alias_method :r3, :retrieve_mp3


  def play_mp3
    begin
      if retrieve_mp3=~/https?:\/\/[\w/:%#\$&\?\(\)~\.=\+\-]+/
        `ffplay -nodisp -loglevel quiet -autoexit -t '231' #{data}`
      else
        return '*nope: いや,いいえ*(in mp3)'
      end
    rescue;return '*nope: いや,いいえ*(in mp3)';end;end
    alias_method :p3, :play_mp3

end#def class end
