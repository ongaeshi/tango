require "tango/json_file"
require "tango/word"

module Tango
  class Words
    def initialize(json)
      @json = json
      
      @word_hash = {}      
      @json.data.each do |k, v|
        @word_hash[k] = Word.new(k, v)
      end
    end
    
    def to_a
      @word_hash.to_a.map { |e| e[1] }
    end
    
    def exist?(word)
      @word_hash[word] != nil
    end
    
    def add_or_update(word, translation)
      if exist? word
        w = update_word(word, translation)
      else
        w = new_word(word, translation)
      end
      
      @word_hash[word] = w      
      puts w.astr
    end
    
    def rm(word)
      @word_hash.delete(word)
    end

    def save
      @json.data = {}
      
      @word_hash.each do |k, v|
        @json.data[k] = v.data
      end
      
      @json.save
    end

    def new_word(word, translation)
      t = Time.now
      
      data = {
        "count" => 1,
        "created_at" => timestr(t),
        "updated_at" => timestr(t),
      }
        
      data["translation"] = translation if translation
      
      Word.new(word, data)
    end
    
    def update_word(word, translation)
      w = @word_hash[word]
      
      t = Time.now
      
      data = w.data
      data["translation"] = translation if translation
      data["count"] += 1
      data["updated_at"] = timestr(t)
      
      w
    end
    
    def timestr(t)
      sprintf("%04d-%02d-%02d %02d:%02d", t.year, t.month, t.day, t.hour, t.min)
    end
  end
end
