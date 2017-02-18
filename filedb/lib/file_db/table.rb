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
         searching = arg[:where].keys
        if searching.include?(:id)
          movie_index = (arg[:where][:id]) - 1
          data[category][movie_index]               
        else 
          searching[0]
          key_name = arg[:where].keys[0]
          key_value = arg[:where][key_name]
          arr =[]
          data[category].each do |movie|
            arr << movie if movie["#{key_name}"] == key_value
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
