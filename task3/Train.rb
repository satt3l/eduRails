class Train
  attr_accessor :speed
  attr_reader :car_count

  def initialize(id, type, car_count)
    @id = id
    @type = type
    @car_count = car_count
  end
  def change_speed(value)
    self.speed = value
  end
  def assign_route(route)
    
  end
end
