require "uri";require "open-uri"
puts "*plz type something*"
data=[]
begin
loop do
  begin
  puts "*plz type something*" if !data.empty?
rescue;puts "*plz type something*";end
  unless (word=gets.chomp.to_s)==nil
  puts "*Well, let me see...*"
  open(URI.encode("https://ejje.weblio.jp/content/#{word}")){|mean|
    data=mean.read.scan(/https:\/\/.*?\.mp3/)[0]
    begin
    if !data.empty?
      `ffplay -nodisp -loglevel quiet -autoexit -t '231' #{data}`
      puts ""
    else
      puts '*nope: いや,いいえ*'
    end
    rescue
      puts '*nope: いや,いいえ*'
    end
  }
  if word == "exit" ||word == "end" ||word == "finish";sleep(1);exit;end
  else
    puts "*駄目: tabu,taboo*"
  end
end
rescue Interrupt
  puts "*interrupt: (…を)さえぎる,中断する,腰を折る*"
end
