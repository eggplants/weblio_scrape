#encoding: UTF-8
require_relative "class.rb"
begin

  exe="word." +""#debug method

  unless (word = Weblio.new(ARGV[0]))==nil
      p eval(exe)
      exit
    else
      puts "*plz type something*"

      loop do
        unless (word=gets.chomp.to_s)==nil
          puts "*Well, let me see...*"

          begin
            ############
            p eval(exe)
            ############
          rescue NoMethodError
            puts '*none: (…の)いずれも…ない,どれも…ない,少しも…ない,…はよせ,やめなさい,だれも…ない*'
          rescue OpenSSL::SSL::SSLError || Errno::ECONNRESET
            puts "*unconnected: つながっていない,関係のない,縁故のない*"
          rescue SocketError
            puts "*unreachable: 近づきがたい位置にあるか、状況にある*"
          end#begin

        else
          puts "*駄目: tabu,taboo*"
          next
        end#unless-2

        if word == "exit" ||word == "end" ||word == "finish";sleep(1);puts ".";exit;end
        puts "*plz type something*"

      end#loop

  end#unless-1

#ctrl-C
rescue Interrupt
  puts '*interrupt: (…を)さえぎる,中断する,腰を折る*'
end
