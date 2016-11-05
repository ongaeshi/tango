module Tango
  class Word
    attr_reader :word
    attr_reader :data
    
    def initialize(word, data)
      @word = word
      @data = data
    end
    
    def translation
      @data["translation"]
    end
    
    def count
      @data["count"]
    end
    
    def updated_at
      r = @data["updated_at"].scan(/(\d+)-(\d+)-(\d+) (\d+):(\d+)/)
      r = r[0].map { |e| e.to_i }
      
      Time.new(r[0], r[1], r[2], r[3], r[4])
    end
    
    def astr
      if count > 1
        # str = "#{word} (#{count}) #{translation} "
        str = "#{word} #{translation} "
      else
        str = "#{word} #{translation} "
      end
      
      AttrString.new(str) +
      AttrString.new("[wis]", link: "mkwisdom://jp.monokakido.mkwisdom/search?text=#{word}") + " " +
      AttrString.new("[alc]", link: "http://eow.alc.co.jp/search?q=#{word}")
    end
  end
end
