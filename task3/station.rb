class Station
#  attr_reader :trains
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_leave(train)
    @trains.delete(train)
  end

  def train_enter(train)
    self.trains << train
  end

  def get_trains(train_type = nil)
    result = []
    @trains.each do |train|
      result << train if (train_type.nil? or train_type == train.type) # I know, no need for brackets, just want to stress that these expressions connected
    end
    puts "Trains on station #{self.name}: #{result}, \nOverall trains of specified type are: #{result.size}"
    return result
  end

end
