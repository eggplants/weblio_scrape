#to make available: CSV wordlist, sentence - > noun, level average by each kind
require "uri"
require "open-uri"

module Weblio

class GetWordData

def initialize(word)
  @word = word
  @data = open(URI.encode("https://ejje.weblio.jp/content/#{@word}")).read
end

def getLevelData
    return @data.scan(/learning-level-table-wrap(.*)語彙力テストを受ける/).flatten[0]
    .scan(/>(.*?)</).flatten.delete_if {
        | a | a == ''
    }
    .map {
        | a | a.encode("UTF-8")
    }.join("/")
    .scan(/(.*?\/：\/.*?\/|.*?\/：\/.*?$)/)
    .map {
        | i | i[0].gsub(/\//, '').sub('&amp;', '').split("：")
    }.to_h
end

# look up meanings
def meaning_arr
    return (data = @data.scan(/content=\"(.*)\"?>/).flatten)[-1]
    .include?(":") ?
    data[-1].gsub('"', '').sub(/[a-z ]+:/, '').split(',') 
    : nil
end

def meaning_hash
    return {
    "#{@word}" => meaning_arr
    }
end

# level

def level
    exist = {
        "レベル" => nil,
        "英検" => nil,
        "学校レベル" => nil,
        "TOEIC® LRスコア" => nil
    }
    return getLevelData.each {
    | k, v | exist[k] = v
    }
end

# mp3 file of noun
def getAudioUri
    return @data.scan(/https:\/\/.*?\.mp3/)[0]
end

def getAudio(path = ".")
    filename = @word + "_audio.mp3"
    File.open(filename, "w") {
        | f | f.write open(getAudioUri).read
    }
end

def play_mp3# ffmpegが必要
    begin
        if (data = getAudioUri) =~ /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+/
            `ffplay -nodisp -loglevel quiet -autoexit -t '231' #{data}`
        else
            return 'cannot play!'
        end
    rescue
        return 'Some error happened!'
    end
end

end

end
