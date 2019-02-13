require_relative "./class.rb"
str=gets.chomp.split
data=[]
str.each{|word|data<< Weblio.new(word).r3}
data.each{|d|d.p3}