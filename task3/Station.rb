class Station
#  attr_reader :trains

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

  def get_trains(train_type = 'all')
    @trains.each_pair do |id, type|
      if train_type == 'all'
        puts "Train id: #{id}, train type: #{type}"      
      end
     puts "Train id: #{id}, train type: #{type}" if train_type == type
    end
  end

end
