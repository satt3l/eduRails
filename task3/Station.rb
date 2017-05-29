class Station
#  attr_reader :trains
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = {}
  end
  
  def add_train(id, type)
    @trains[id] = type
  end 

  def remove_train(id)
    @trains.delete(id)
  end

  def set_train(train)
    self.trains[train.id] = train.type 
  end

  def get_trains(train_type = 'all')
    result = []
    @trains.each_pair do |id, type|
      if train_type == 'all'
        puts "Train id: #{id}, train type: #{type}"      
	result << {id: id, type: type}
      end
      if train_type == type
        puts "Train id: #{id}, train type: #{type}" 
        result << {id: id, type: type}
      end
    end
    puts "Trains on station: #{result}, \nOverall trains of specified type are: #{result.size}"
    return result
  end

end
