require "uri";require "open-uri"
def level(word)
  open(URI.encode("https://ejje.weblio.jp/content/#{word}")){|mean|
    data=mean.read.scan(/learning-level-table-wrap(.*)語彙力テストを受ける/).flatten[0]
    .scan(/>(.*?)</).flatten.delete_if{|a|a==""}.map{|a|a.encode("UTF-8")}.join("/").scan(/(.*?\/：\/.*?\/|.*?\/：\/.*?$)/)
    return data.join(", ").gsub(/&amp;|\//,"").gsub(/：/,":")
  }
end
puts "*plz type something*"
begin
  loop do
    if (word=gets.chomp.to_s)==nil;puts "*駄目: tabu,taboo*";next;end
    puts "*Well, let me see...*"
    unless word =~ /^[a-zA-Z]+$/;puts "*日本語: Japanese*";next;end
    begin
      puts level(word)
    rescue NoMethodError
      puts '*none: (…の)いずれも…ない,どれも…ない,少しも…ない,…はよせ,やめなさい,だれも…ない*'
    end
    if word == "exit" ||word == "end" ||word == "finish";sleep(3);exit;end
  end
rescue Interrupt
  puts '*interrupt: (…を)さえぎる,中断する,腰を折る*'
end
