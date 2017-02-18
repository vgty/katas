module FileDb
  class Database
    attr_reader :data
    def initialize(data_file)
      file = File.read(data_file)
      @data = JSON.parse(file)
    end
    
    def table_names
      ["movies", "directors"]
    end
    
    def table(category="movies")
      Table.new(category, data)
    end 
     
  end
end
