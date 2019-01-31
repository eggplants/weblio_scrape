require "uri"
require "open-uri"
unless ARGV[0]==nil
  open(URI.encode("https://ejje.weblio.jp/content/#{ARGV[0]}")){|mean|
    data=mean.read.scan(/content=\"(.*)\"?>/).flatten
    puts data[-1].gsub('"',"")
  }
else
  puts "駄目."
end
