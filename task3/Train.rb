class Train
  attr_accessor :car_count, :speed, :route_position, :route
  attr_reader :debug_enabled, :id, :type
  def initialize(id, type, car_count, debug_enabled = false)
    @id = id
    @type = type
    @car_count = car_count
    @speed = 0
    @debug_enabled = debug_enabled 
    @route = nil
    puts "Object created with id =#{@id}, type = #{@type}, car_count = #{@car_count}, start speed = #{@speed}" if @debug_enabled
  end
  def debug_enabled?
    debug_enabled
  end
  def gain_speed(speed)
    change_speed(speed)
    puts "Trains gains speed of #{speed}" if debug_enabled?
  end
  def move_forward
    change_route_position('forward')
    puts "Moved forward" if debug_enabled?
  end
  def move_backward
    change_route_position('backward')
    puts "Moved bacward" if debug_enabled?
  end
  def stop
    change_speed(0)
    puts "Stopped, speed = 0, status = #{is_stopped?}" if debug_enabled?
  end 
  def is_stopped?
    if self.speed == 0 
      true
    else
      false
    end
#    puts "Stopped, speed = 0, status = #{is_stopped?}" if debug_enabled?
  end
  def assign_route(route)
    return "Must be type of Route" unless route.is_a?(Route)
    self.route = route   
    change_route_position('reset')
    puts "Route assigned: #{route}, position reset to #{self.route_position}" if debug_enabled?
  end
  def get_station(type = 'current') # possible values current, next, previous
    unless self.route.is_a?(Route)
      puts "Route not assigned, unable to get location"
      return
    end
    case type
    when 'current'
      puts self.route.stations[self.route_position].name  
    when 'next', 'n'
      if self.route_position == (self.route.stations.size - 1)
        puts self.route.stations.last.name  
      else
        puts self.route.stations[self.route_position + 1].name  
	self.route_position += 1
      end
    when 'previous','prev', 'p'
      if self.route_position == 0
        puts self.route.stations.first.name  
      else
        puts self.route.stations[self.route_position - 1].name  
        self.route_position -= 1
      end
    end 
  end 
  def add_car
    change_car_count('inc')
  end
  def del_car
    change_car_count('dec')
  end
  private
  
  def change_route_position(direction)
    case direction 
    when 'forward', 'f'
      self.route_position += 1 
    when 'backward','back','b' 
      self.route_position -= 1
    when 'reset','res','r'
      self.route_position = 0
    end
    puts "DEBUGA #{self.route.stations[route_position].name}" if debug_enabled? 
    self.route.stations[self.route_position].set_train(self)
  end

  def change_speed(value)
    self.speed = value
  end
  def change_car_count(add_or_remove)
#    puts "It's seems that parameter has unexpected value. Must be 'add', or 'remove'" unless ['add', 'remove'].inlcude?(add_or_remove)
    if is_stopped?
      if add_or_remove.downcase == 'add'
        self.car_count += 1
      elsif add_or_remove.downcase == 'remove'
        self.car_count -= 1
      end
    else
      puts "Unable to change car count while train is moving. You need to stop it first"
    end
  end
  def change_car_count(type = 'nothing')
    unless is_stopped?
      puts "You must stop train before change amount of cars"
      return
    end
    case type.downcase
    when 'increase', 'inc', '++'
      puts "Adding a car. Current number of cars BEFORE: #{self.car_count}"
      self.car_count += 1
    when 'decrease', 'dec', '--'
      puts "Deleteing a car. Current number of cars BEFORE: #{self.car_count}"
      if self.car_count == 0
        puts "No cars already, impossible to remove car"
	return
      end
      self.car_count -= 1
    end
    puts "Number of cars AFTER:  #{self.car_count}" if debug_enabled?
  end
end
