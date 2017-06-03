class Train
  attr_accessor :car_count, :speed, :route_position, :route
  attr_reader :debug_enabled, :id, :type

  def initialize(id, type, car_count = 0, debug_enabled = false)
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
    change_route_position(:next)
    puts "Moved forward" if debug_enabled?
  end

  def move_backward
    change_route_position(:previous)
    puts "Moved backward" if debug_enabled?
  end

  def stop
    change_speed(0)
    puts "Stopped, speed = 0, status = #{is_stopped?}" if debug_enabled?
  end 

  def is_stopped?
    self.speed.zero?
  end

  def assign_route(route)
    return "Must be type of Route" unless route.is_a?(Route)
    self.route = route   
    set_route_position_to_start
    puts "Route assigned: #{route}, position reset to #{self.route_position}" if debug_enabled?
  end

  def get_station(direction = nil) # possible values next, previous
    if self.route.nil?
      puts "Route not assigned, unable to get location"
      return
    end

    return current_station if direction.nil?  
    send("#{direction}_station")
  end 

  def add_car
   self.car_count += 1 if is_stopped?
  end
  
  def del_car
    self.car_count -= 1 if is_stopped? and self.car_count != 0
  end

  private
  
  def set_route_position_to_start
    self.route_position = 0

  end
  def change_route_position(direction)
    send("change_route_position_to_#{direction}")
  end
  
  def current_station
    self.route.stations[self.route_position]
  end

  def is_on_first_station?
    self.route_position == 0
  end
  
  def is_on_last_station?
    self.route_position == self.route.stations.size - 1
  end

  def next_station
    return current_station if is_on_last_station?
    self.route.stations[self.route_position + 1] 
  end

  def previous_station
    return current_staion if is_on_first_station?
    self.route.stations[self.route_position - 1] 
  end

  def change_route_position_to_next
    return if is_on_last_station?
    current_station.train_leave(self)
    next_station.train_enter(self)
    self.route_position += 1
  end

  def change_route_position_to_previous
    return if is_on_first_station?
    current_station.train_leave(self)
    previous_station.train_enter(self)
    self.route_position -= 1
  end

  def change_speed(value)
    self.speed = value
  end

end
