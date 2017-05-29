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

  def train_leave(train)
    @trains.delete(train.id)
  end

  def train_enter(train)
    self.trains[train.id] = train.type 
  end

  def get_trains(train_type = 'all')
    result = []
    @trains.each_pair do |id, type|
      if train_type == 'all'
	result << {id: id, type: type}
      end
      if train_type == type
        result << {id: id, type: type}
      end
    end
    puts "Trains on station #{self.name}: #{result}, \nOverall trains of specified type are: #{result.size}"
    return result
  end

end
