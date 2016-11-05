require "tango/json_file"
require "tango/words"

module Tango
  class Cli
    def initialize
      @json = JsonFile.new("word.json")
      @words = Words.new(@json)
    end
    
    def mainloop
      loop do
        command = prompt

        case command
        when /^l/
          list(command.split[1..-1])
        when /^rm/
          rm(command.split[1..-1])
        when "t"
        when "h"
          help
        else
          add(command)
        end
      end
    end
    
    def add(command)
      cmds = command.split(" ")

      @words.add_or_update(cmds[0], cmds[1])
      @words.save
    end
      
    def list(args)
      words = @words.to_a
      words = words.sort_by { |e| e.updated_at }.reverse
      
      words.each do |e|
        if args.empty?
          puts e.astr
        else
          puts e.astr if e.word.include? args[0]
        end
      end
    end
    
    def rm(args)
      args.each do |e|
        r = @words.rm e
        puts "Not found #{e}" unless r
      end
      
      @words.save
    end
    
    def help
    end
  end
end

