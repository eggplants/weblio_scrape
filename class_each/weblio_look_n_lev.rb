#encoding: UTF-8
require "uri";require "open-uri"
def level(word)
  open(URI.encode("https://ejje.weblio.jp/content/#{word}")){|mean|
    data=mean.read.scan(/learning-level-table-wrap(.*)語彙力テストを受ける/).flatten[0]
    .scan(/>(.*?)</).flatten.delete_if{|a|a==""}.map{|a|a.encode("UTF-8")}.join("/").scan(/(.*?\/：\/.*?\/|.*?\/：\/.*?$)/)

    return data.join(", ").gsub(/&amp;|\//,"").gsub(/：/,":")
  }
end
def lookup(word)
  open(URI.encode("https://ejje.weblio.jp/content/#{word}")){|mean|
    data=mean.read.scan(/content=\"(.*)\"?>/).flatten
    return data[-1].include?(":") ? data[-1].gsub('"',"") : "*nope: いや,いいえ*"
  }
end
puts "*plz type something*"
begin
  loop do
    if (word=gets.chomp.to_s)==nil;puts "*駄目: tabu,taboo*";next;end
    puts "*Well, let me see...*"
    begin
      puts lookup(word)
      unless word =~ /^[a-zA-Z]+$/;puts "*日本語: Japanese(Only shown eng.lv.)*";next;end
      puts level(word)
    rescue NoMethodError
      puts '*none: (…の)いずれも…ない,どれも…ない,少しも…ない,…はよせ,やめなさい,だれも…ない*'
    rescue OpenSSL::SSL::SSLError || Errno::ECONNRESET
      puts "*unconnected: つながっていない,関係のない,縁故のない*"
    rescue SocketError
      puts "*unreachable: 近づきがたい位置にあるか、状況にある*"
    end
    if word == "exit" ||word == "end" ||word == "finish";sleep(1);puts ".";exit;end
  end
rescue Interrupt
  puts '*interrupt: (…を)さえぎる,中断する,腰を折る*'
end
