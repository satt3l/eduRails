Dir['*.rb', '../task3/*.rb'].each{|file| require_relative file}

class SuperMain

  attr_reader :trains, :stations, :routes, :train_cars

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @train_cars = []
  end

  def create_train_car(id, type)
    send("create_train_car_#{type}", id)
  end

  def create_station(name)
#    self.stations << instance_variable_set("@#{name}", Station.new(name))
    self.stations << Station.new(name)
  end
  
  def create_train(id, type)
    send("create_train_#{type}", id)
  end

  def create_route(name, first_station_name, last_station_name )
    #self.routes <<  instance_variable_set("@#{name}", Route.new(first_station, last_station, name))  
    first_station = self.stations.select{|s| s.name == first_station_name}.first
    last_station = self.stations.select{|s| s.name == last_station_name}.first
    self.routes <<  Route.new(first_station, last_station, name)
  end

  def add_station_to_route(route_name, station_name, position)
    position = (position.nil? or position.empty?) ? -2 : position.to_i
    puts "Position: #{position}"
    station = self.stations.select{|s| s.name == station_name}.first
    self.routes.select{|r| r.name == route_name}.first.add_station(station, position)
  end

  def remove_station_from_route(route_name, station_name)
    station = self.stations.select{|s| s.name == station_name}.first
    self.routes.select{|r| r.name ==route_name}.first.remove_station(station)
  end

  def remove_station(name)
    station = self.stations.select{|s| s.name == name}.first
    self.stations.delete(station)
  end

  def train_assign_route(train, route)
    self.trains[train].assign_route(route)
  end

  def train_add_car(train)
    self.trains[train].add_car
  end

  def train_remove_car(train)
    self.trains[train].remove_car
  end

  def train_move_forward(train)
    self.trains[train].move_forward
  end
  
  def train_move_backward(train)
    self.trains[train].move_backward
  end
  
  def get_trains_on_station(station)
    self.stations[station].get_trains 
  end
  
  def print_stations
    puts "Stations list: #{self.stations}"
  end

  def print_trains
    puts "Trains list: #{self.trains}"
  end

  def print_routes
    puts "Routes list: #{self.routes}"
  end

  def print_cars
    puts "Train cars list: #{self.train_cars}"
  end
  private
  attr_writer :trains, :stations, :routes, :cars

  def create_train_cargo(id)
    index = self.cargo_cars.size + 1 
    self.trains << CargoTrain.new(id)
  end

  def create_train_passenger(id)
    self.trains << PassengerTrain.new(id)
  end
   
  def create_train_car_passenger(id)
    self.train_cars << PassengerTrainCar.new(id)
  end

  def create_train_car_cargo(id)
    self.train_cars << CargoTrainCar.new(id) 
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
  puts '6. Move train to next station'
  puts '7. Move train to previous station'
  puts '8. Stop train'
  puts '9. Change train speed'
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
    $super_main.print_cars
    puts 'Specify name of train and car name to add. Please keep for each train type the same car type must be used and train must be stopped at the moment.'
    input = gets.chomp.split
    train_name, car_name = input[0], input[1]
    $super_main.add_car(train_name, car_name)
  when '6'
    $super_main.print_stations
    puts 'Specify which train to move forward'
    $super_main.train_move_forward(gets.chomp)
  when '7'
    $super_main.print_stations
    puts 'Specify which train to move backward'
    $super_main.train_move_backward(gets.chomp)
  when '8'
    $super_main.print_trains
    puts 'Specify which train to stop'
    $super_main.stop_train(gets.chomp)
  when '9'
    $super_main.print_trains
    puts 'Specifyg train name and speed'
    input = gets.chomp.split
    train_name, speed = input[0], input[1]
    $super_main.gain_speed(train_name, speed)
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
