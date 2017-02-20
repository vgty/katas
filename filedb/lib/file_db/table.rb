module FileDb
  class Table
    attr_reader :data, :category
    
    def initialize(category, data)
      @category = category
      @data = data
    end
    
    def id_generator(element)
      data_length = data[category].length
      element.merge!(id: "#{data_length}".to_i + 1)
    end
    
    def select(req="")
      if req.is_a? String
        data[category]  
      elsif req.has_key?(:where)
         searching = req[:where].keys
        if searching.include?(:id)
          element_index = (req[:where][:id]) - 1
          data[category][element_index]               
        else 
          key_name = req[:where].keys[0]
          key_value = req[:where][key_name]
          arr =[]
          data[category].each do |elem|
            arr << elem if elem["#{key_name}"] == key_value
          end
          arr
        end        
      end
    end
    
    def insert(element)
      id_generator(element)
      data[category] << element
      element
    end
    
    def update(req)
      element = select(req)
      key_name = req[:values].keys[0]
      key_value = req[:values][key_name]
      element["#{key_name}"] = key_value
      element
    end
    
    def delete(req)
      element = select(req)
      data[category] - [element]
    end
    
  end
end
