Dir['*.rb', '../task3/*.rb'].each{|file| require_relative file}

class SuperMain

  attr_reader :trains, :stations, :routes, :train_cars

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @train_cars = []
  end

  def create_train_car(name, type)
    send("create_train_car_#{type}", name) if get_obj_from_array_by_name(self.train_cars, name).nil?
  end

  def create_station(name)
#    self.stations << instance_variable_set("@#{name}", Station.new(name))
    self.stations << Station.new(name) if get_station_obj_by_name(name).nil?
  end
  
  def create_train(name, type)
    send("create_train_#{type}", name) if get_train_obj_by_name(name).nil?
  end

  def create_route(route_name, first_station_name, last_station_name )
    #self.routes <<  instance_variable_set("@#{name}", Route.new(first_station, last_station, name))  
    #return if [route_name, first_station_name, last_station_name].include?(nil)
    #return unless get_route_obj_by_name(route_name).nil?
    first_station = get_station_obj_by_name(first_station_name)
    last_station = get_station_obj_by_name(last_station_name)
    self.routes <<  Route.new(first_station, last_station, route_name)
  end

  def add_station_to_route(route_name_or_index, station_name, position)
    position = (position.nil? or position.empty?) ? -2 : position.to_i
    station = get_obj_from_array_by_name(self.stations, station_name)
    index = get_index_of_obj_in_array(self.routes, route_name_or_index)    
    self.routes[index].add_station(station, position)
  end

  def remove_station_from_route(route_name_or_index, station_name_or_index)
    station = get_station_obj_by_name(station_name)
    route_index = get_index_of_obj_in_array(self.routes, route_name_or_index)
    self.routes.select{|r| r.name ==route_name}.first.remove_station(station)
  end

  def remove_station(name_or_index)
    index = get_index_of_obj_in_array(self.stations, name_or_index)
    puts "Index is #{index}"
    self.stations.delete_at(index)
  end

  def train_assign_route(train_name_or_index, route_name_or_index)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    route = get_obj_from_array_by_name(self.routes, route_name_or_index)
    self.trains[train_index].assign_route(route)
  end

  def train_add_car(train_name_or_index, train_car_name_or_index)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    car_index = get_index_of_obj_in_array(self.train_cars, train_car_name_or_index)
    self.trains[train_index].add_car(self.train_cars[car_index])
  end

  def train_remove_car(train_name_or_index, train_car_name_or_index)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    car_index = get_index_of_obj_in_array(self.train_cars, train_car_name_or_index)
    self.trains[index].remove_car(self.train_cars[car_index])
  end

  def train_move_forward(train_name_or_index)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    self.trains[train_index].move_forward
  end
  
  def train_move_backward(train_name_or_index)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    self.trains[train_index].move_backward
  end

  def train_change_speed(train_name_or_index, speed)
    train_index = get_index_of_obj_in_array(self.trains, train_name_or_index)
    self.trains[train_index].set_speed(speed)
  end

  def get_trains_on_station(station_name_or_index)
    staion_index = get_index_of_obj_in_array(self.stations, station_name_or_index)
    self.stations[staion_index].get_trains 
  end
  
  def print_stations
    puts "Stations list:"
    print_object_index_name(self.stations)
  end

  def print_trains
    puts "Trains list:"
    print_trains_full_info(self.trains)
  end

  def print_routes
    puts "Routes list:"
    print_object_index_name(self.routes)
  end

  def print_cars
    puts "Cars list:"
    print_object_index_name(self.train_cars)
  end
  private
  attr_writer :trains, :stations, :routes, :train_cars

  def is_numeric?(input)
    # it seems to me that this method should be declared elsewhere, but, anyway, it's here for now :)
    Integer(input) rescue false
  end

  def get_obj_from_array_by_name(obj, name)
    # Is it possible to parametrize name? I mean, use ANY attribute, like with send("some_method_#{var}) example?
    obj.select{|item| item.name == name}.first 
  end

  def get_index_of_obj_in_array(obj, attribute_name_or_index)
    if is_numeric?(attribute_name_or_index)
      attribute_name_or_index.to_i
    else
      obj.index(get_obj_from_array_by_name(obj, attribute_name_or_index))
    end
  end

  def get_train_obj_by_name(name)
    self.trains.select{|item| item.name == name}.first
  end

  def get_car_obj_by_name(name)
    self.train_cars.select{|item| item.name == name}.first
  end

  def get_station_obj_by_name(name)
    self.stations.select{|item| item.name == name}.first
  end

  def get_route_obj_by_name(name)
    self.routes.select{|item| item.name == name}.first
  end

  def create_train_cargo(name)
    puts "CREATE TRAIN CARG with parameter :#{name}"
    self.trains << CargoTrain.new(name)
  end

  def create_train_passenger(name)
    self.trains << PassengerTrain.new(name)
  end
   
  def create_train_car_passenger(name)
    self.train_cars << PassengerTrainCar.new(name)
  end

  def create_train_car_cargo(name)
    self.train_cars << CargoTrainCar.new(name) 
  end

  def print_object_index_name(object)
    object.each_with_index do |item, index|
      puts "Index: #{index}, name: #{item.name}"
    end
  end
  def print_trains_full_info(trains)
    trains.each_with_index do |train, index|
      puts "Train index: #{index}, train name: #{train.name}, cars list: #{train.car_list}, current_speed: #{train.speed} assigned route: #{train.route} "
    end
  end
end

def manage_stations
  puts '1. Create station. '
  puts '2. Get trains on station'
  puts '3. Delete station'
  puts '0. Back'
  case gets.chomp
  when '1'
    puts 'Enter station name'
    $super_main.create_station(gets.chomp)
  when '2'
    $super_main.print_stations
    puts 'Enter station name'
    $super_main.get_trains_on_station(gets.chomp)
  when '3'
    $super_main.print_stations
    puts 'Enter station name'
    $super_main.remove_station(gets.chomp)
  when '0'
    return
  end
end

def manage_routes
  puts '1. Create route'
  puts '2. Add station to route'
  puts '3. Delete station from route'
  puts '0. Back'
  case gets.chomp
  when '1'
    $super_main.print_stations
    puts 'Enter route name, first station, last station.'
    input = gets.chomp.split
    first_station, last_station, route_name = input[0], input[1], input[2]
    $super_main.create_route(first_station, last_station, route_name)
  when '2'
    $super_main.print_stations
    $super_main.print_routes
    puts 'Specify route name, station name, index where to insert new station (if none specified - will be inserted as previous to end).'
    input = gets.chomp.split
    route, station, position = input[0], input[1], input[2]
    $super_main.add_station_to_route(route, station, position)
  when '3'
    $super_main.print_routes
    $super_main.print_stations
    puts 'Specify route to work with and station to delete from specified route'
    input = gets.chomp.split
    route_name, station_name = input[0], input[1]
    $super_main.remove_station_from_route(route_name, station_name)
  when '0'
    return
  end
    $super_main.print_routes
end

def manage_trains
  puts '1. Create passenger car'
  puts '2. Create cargo car'
  puts '3. Create passenger train'
  puts '4. Create cargo train'
  puts '5. Add car to train'
  puts '6. Assign route to train'
  puts '7. Move train to next station'
  puts '8. Move train to previous station'
  puts '9. Stop train'
  puts '10. Change train speed'
  puts '0. Back'
  case gets.chomp
  when '1'
    $super_main.print_cars
    puts 'Enter car name (id)'
    $super_main.create_train_car(gets.chomp, 'passenger')
  when '2'
    $super_main.print_cars
    puts 'Enter car name (id)'
    $super_main.create_train_car(gets.chomp, 'cargo')
  when '3'
    puts 'Enter train name (id).'
    $super_main.create_train(gets.chomp, 'passenger')
  when '4'
    puts 'Enter train name (id).'
    $super_main.create_train(gets.chomp, 'cargo')
  when '5'
    $super_main.print_trains
    $super_main.print_cars
    puts 'Specify name of train and car name to add. Please keep in mind that for each train type the same car type must be used and train must be stopped at the moment.'
    train_name, car_name = gets.chomp.split
    $super_main.train_add_car(train_name, car_name)
  when '6'
    $super_main.print_routes
    $super_main.print_trains
    puts 'Specify name or index of train and name or index of route to assign to'
    train_name, route_name = gets.chomp.split
    puts "TRAIN: #{train_name}, ROUTE #{route_name}"
    $super_main.train_assign_route(train_name, route_name)
  when '7'
    $super_main.print_trains
    $super_main.print_routes
    $super_main.print_stations
    puts 'Specify which train to move forward'
    $super_main.train_move_forward(gets.chomp)
  when '8'
    $super_main.print_stations
    puts 'Specify which train to move backward'
    $super_main.train_move_backward(gets.chomp)
  when '9'
    $super_main.print_trains
    puts 'Specify which train to stop'
    $super_main.train_change_speed(gets.chomp, 0)
  when '10'
    $super_main.print_trains
    puts 'Specifyg train name and speed'
    train_name, speed = gets.chomp.split
    $super_main.train_change_speed(train_name, speed)
  when '0'
    return
  end
end

$super_main = SuperMain.new
puts 'Lets go'
loop do
  puts '1. Manage stations'
  puts '2. Manage routes'
  puts '3. Manage trains'
  puts '0. Exit'
  case gets.chomp
  when '1'
    manage_stations
  when '2'
    manage_routes
  when '3'
    manage_trains
  when '0'
    exit
  end
end
