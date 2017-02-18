module FileDb
  class Table
    attr_reader :data, :category
    
    def initialize(category, data)
      @category = category
      @data = data
    end
    
    def select(arg="")
      if arg.is_a? String
        data[category]  
      elsif arg.has_key?(:where)        
        if arg[:where].has_key?(:id)
          data[category][arg[:where][:id] - 1]               
        elsif arg[:where].has_key?(:director_id)
          director = arg[:where][:director_id]
          arr =[]
          data[category].each do |movie|
            arr << movie if movie["director_id"] == director
          end
          arr
        end        
      end
    end
    
    def insert(new_movie)
      id_generator(new_movie)
      data[category] << new_movie
    end
    
    def id_generator(movie)
      data_length = data[category].length
      movie.merge!(id: "#{data_length}".to_i + 1)
    end
    
  end
end
