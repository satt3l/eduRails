Dir['*.rb', '../task3/*.rb'].each{|file| require_relative file}

class SuperMain

  attr_reader :trains, :stations, :routes, :train_cars

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @passenger_cars = []
  end

  def create_station(name)
   # self.stations << instance_variable_set("name#{self.stations.size + 1}", Station.new(name))
    self.stations << Station.new(name)
    puts self.stations
    puts 'shit'
  end
  
  def remove_station(name)
    self.stations.delete_at(self.stations.index{|station| station.name == name})
  end
  
  def create_train(type, id)
    send("create_train_#{type}(id)")
  end

  def create_route(first_station, last_station, name)
    self.routes <<  Route.new(first_station, last_station)  
  end

  def add_station_to_route(route, station, position = -2 )
    self.routes[route].add_station(staion, position)
  end
  def remove_station_from_route(route, station)
    self.routes[route].remove_station(station)
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
  # create sation
  #create route
  private
  attr_writer :trains, :stations, :routes, :cargo_cars, :passenger_cars

  def create_train_cargo(id)
    index = self.cargo_cars.size + 1 
    self.trains << instance_variable_set("cargo_train#{index}", CargoTrainCar.new(id)) 
  end

  def create_train_passenger(id)
    index = self.passenger_cars.size + 1 
    self.trains << instance_variable_set("passenger_train#{index}", PassengerTrainCar.new(id)) 
  end

end


super_main = SuperMain.new
puts 'Lets go'
loop do
  puts '1. Manage stations'
  puts '2. Manage routes'
  puts '3. Manage trains'
  puts '0. Exit'
  case gets.chomp
  when '1'
    puts '1. Create station. '
    puts '2. Get trains on station'
    puts '3. Delete station'
    puts '0. Back'
    case gets.chomp
    when '1'
      puts 'Enter station name'
      super_main.create_station(gets.chomp)
    when '2'
      super_main.print_stations
      puts 'Enter station name'
      super_main.get_trains_on_station(gets.chomp)
    when '3'
      super_main.print_stations
      puts 'Enter station name'
      super_main.remove_station(gets.chomp)
    when '0'
      break
    end
  when '2'
    puts '1. Create route'
    puts '2. Add station to route'
    puts '3. Delete station from route'
    puts '4. back'
    case gets.chomp
    when '1'
      super_main.print_stations
      puts 'Enter first station, last station, route name.'
      input = gets.chomp.split
      first_station, last_station, route_name = input[0], input[1], input[2]
      super_main.create_route(first_station, last_station, route_name)
    when '2'
      super_main.print_stations
      super_main.print_routes
      puts 'Specify route name, station name, index where to insert new station (if none specified - will be inserted as previous to end).'
      input = gets.chomp.split
      route, station, position = input[0], input[1], input[2]
      super_main.add_station_to_route(route, station, position)
    when '3'
      super_main.print_routes
      super_main.print_stations
      puts 'Specify route to work with and station to delete from specified route'
      super_main.remove_station_from_route(gets.chomp)
    when '4'
      break
    end
      super_main.print_routes
  when '3'
  when '0'
    exit
  end
end
