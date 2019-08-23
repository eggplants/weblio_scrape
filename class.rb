#this program is required "ffplay"
#
##to make available: CSV wordlist, sentence->noun, level average by each kind
#
#...i hate test
require "uri";require "open-uri"

module Weblio

  class GetWordData
  def initialize(word)
    @word = word
  end

  #internal
  def retrieve_data
    return open(URI.encode("https://ejje.weblio.jp/content/#{@word}")).read
  end
  alias_method :rd, :retrieve_data


  def self.ret_data_lv
    return rd.scan(/learning-level-table-wrap(.*)語彙力テストを受ける/).flatten[0]
    .scan(/>(.*?)</).flatten.delete_if{|a|a==""}
    .map{|a|a.encode("UTF-8")}.join("/")
    .scan(/(.*?\/：\/.*?\/|.*?\/：\/.*?$)/)
  end
  class << self; alias_method :rdl, :ret_data_lv; end

  #look up meanings
  def self.lookup_s
    data=rd.mean.read.scan(/content=\"(.*)\"?>/).flatten
    return data[-1].include?(":") ? data[-1].gsub('"',"") : "*nope: いや,いいえ*"
  end
  class << self; alias_method :lu_s, :lookup_s; end


  def self.lookup_a
    return lookup_s.gsub(/: /,",").split(",")
  end
  class << self; alias_method :lu_a, :lookup_a; end


  def self.lookup_h
    return {:"#{(v = lu_a).shift}" => v}
  end
  class << self; alias_method :lu_h, :lookup_h; end

  #level
  def self.level_s
    return rdl.join(", ").gsub(/&amp;|\//,"").gsub(/：/,":")
  end
  class << self; alias_method :lv_s, :level_s; end


  def self.level_a
    exist = {"レベル":nil,"英検":nil,"学校レベル":nil,"TOEIC® LRスコア":nil}
    lv_s.split(", ").map{|a|a.split(":")}.map{|o,e|exist["#{o}"]=e}
    return exist.to_a
  end
  class << self; alias_method :lv_a, :level_a; end


  def self.level_h
    return lv_a.to_h
  end
  class << self; alias_method :lv_h, :level_h; end

  #mp3 file of noun
  def retrieve_mp3
    return rd.scan(/https:\/\/.*?\.mp3/)[0]
  end
  alias_method :r3, :retrieve_mp3


  def self.play_mp3
    begin
      if (data=retrieve_mp3) =~ /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+/
        `ffplay -nodisp -loglevel quiet -autoexit -t '231' #{data}`
      else
        return '*nope: いや,いいえ*(in mp3)'
      end
    rescue
      return '*nope: いや,いいえ*(in mp3)'
    end
  end
  class << self; alias_method :p3, :play_mp3; end

end

end
