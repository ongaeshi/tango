module Tango
  class JsonFile
    attr_accessor :data
    
    def initialize(filename)
      @filename = filename
      
      if File.exist? @filename
        File.open(@filename) do |f|
         @data = JSON.parse(f.read)
        end
      else
        @data = {}
      end
    end
    
    def save
      File.open(@filename, "w") do |f|
        f.write JSON.stringify(@data)
      end
    end
  end
end