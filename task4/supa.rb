Dir[ '../task3/*.rb'].each{|file| require_relative file}

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
    puts self.stations.select{|i| i.name == name}
    self.stations.delete(self.stations.select{|station| station.name == name})
  end
  
  def create_train(type, id)
    send("create_train_#{type}(id)")
  end

  def create_route(first_station, last_station, name)
    self.routes << name = Route.create(first_station, last_station)  
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

