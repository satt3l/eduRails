class Train
  attr_reader :debug_enabled, :type, :name, :car_list, :speed, :route, :route_position

  def initialize(name, debug_enabled = false)
    @name = name
    @speed = 0
    @debug_enabled = debug_enabled 
    @route = nil
    @car_list = []
    @route_position = nil
    puts "Object created with name =#{@name}, type = #{@type}, car_count = #{@car_list.size}, start speed = #{@speed}" if @debug_enabled
  end

  def car_count
    self.car_list.size
  end

  def add_car(train_car)
    # to be implented by subclass
    stopped?
  end
  
  def remove_car(train_car)
    stopped? 
  end

  def debug_enabled?
    debug_enabled
  end

  def set_speed(speed)
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
    puts "Stopped, speed = 0, status = #{stopped?}" if debug_enabled?
  end 

  def stopped?
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

  protected
  attr_writer :car_list, :speed, :route_position, :route

  def set_route_position_to_start
    # common for all trains
    self.route_position = 0
  end

  def change_route_position(direction)
    # common for all trains
    send("change_route_position_to_#{direction}")
  end
  
  def current_station
    # common for all trains
    self.route.stations[self.route_position]
  end

  def on_first_station?
    # common for all trains
    self.route_position == 0
  end
  
  def on_last_station?
    # common for all trains
    self.route_position == self.route.stations.size - 1
  end

  def next_station
    # common for all trains
    return current_station if on_last_station?
    self.route.stations[self.route_position + 1] 
  end

  def previous_station
    # common for all trains
    return current_staion if on_first_station?
    self.route.stations[self.route_position - 1] 
  end

  def change_route_position_to_next
    # common for all trains
    return if on_last_station?
    current_station.train_leave(self)
    next_station.train_enter(self)
    self.route_position += 1
  end

  def change_route_position_to_previous
    # common for all trains
    return if on_first_station?
    current_station.train_leave(self)
    previous_station.train_enter(self)
    self.route_position -= 1
  end

  def change_speed(value)
    # common for all trains
    self.speed = value
  end


  def remove_car_from_train(train_car) 
    # to be implemented by subclass
    raise'Abstrace method'
  end
end
