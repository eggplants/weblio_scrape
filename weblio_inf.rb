require "uri";require "open-uri"
puts "*plz type something*"
begin
loop do
  unless (word=gets.chomp.to_s)==nil
  puts "*Well, let me see...*"
  open(URI.encode("https://ejje.weblio.jp/content/#{word}")){|mean|
    data=mean.read.scan(/content=\"(.*)\"?>/).flatten
    puts data[-1].include?(":") ? data[-1].gsub('"',"") : "*nope: いや,いいえ*"
  }
  if word == "exit" ||word == "end" ||word == "finish";sleep(3);exit;end
  else
    puts "*駄目: tabu,taboo*"
  end
end
rescue Interrupt
  puts "*interrupt: (…を)さえぎる,中断する,腰を折る*"
end
