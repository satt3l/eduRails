Dir['*.rb', '../task3/*.rb', '../task5/*.rb', '../task6/*.rb'].each { |file| require_relative file }
require 'json'

class SuperMain
  attr_reader :trains, :stations, :routes, :train_cars

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @train_cars = []
  end

  def create_train_car(name, type, capacity)
    send("create_train_car_#{type}", name, capacity) if get_obj_from_array_by_name(train_cars, name).nil?
  end

  def create_station(name)
    stations << Station.new(name) if get_station_obj_by_name(name).nil?
  end

  def create_train(id, name, type)
    send("create_train_#{type}", id, name) if get_train_obj_by_name(name).nil?
  end

  def create_route(route_name, first_station_name, last_station_name)
    first_station = get_station_obj_by_name(first_station_name)
    last_station = get_station_obj_by_name(last_station_name)
    routes << Route.new(route_name, first_station, last_station)
  end

  def add_station_to_route(route_name_or_index, station_name_or_index, position)
    position = position.nil? || position.empty? ? -2 : position.to_i
    station_index = get_index_of_obj_in_array(stations, station_name_or_index)
    station = stations[station_index]
    route_index = get_index_of_obj_in_array(routes, route_name_or_index)
    routes[route_index].add_station(station, position)
  end

  def remove_station_from_route(route_name_or_index, _station_name_or_index)
    station = get_station_obj_by_name(station_name)
    route_index = get_index_of_obj_in_array(routes, route_name_or_index)
    routes.select { |r| r.name == route_name }.first.remove_station(station)
  end

  def remove_station(name_or_index)
    station_index = get_index_of_obj_in_array(stations, name_or_index)
    stations.delete_at(station_index)
  end

  def train_assign_route(train_name_or_index, route_name_or_index)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    route_index = get_index_of_obj_in_array(routes, route_name_or_index)
    trains[train_index].assign_route(routes[route_index])
  end

  def train_add_car(train_name_or_index, train_car_name_or_index)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    car_index = get_index_of_obj_in_array(train_cars, train_car_name_or_index)
    trains[train_index].add_car(train_cars[car_index])
  end

  def train_remove_car(train_name_or_index, train_car_name_or_index)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    car_index = get_index_of_obj_in_array(train_cars, train_car_name_or_index)
    trains[index].remove_car(train_cars[car_index])
  end

  def train_move_forward(train_name_or_index)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    trains[train_index].move_forward
  end

  def train_move_backward(train_name_or_index)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    trains[train_index].move_backward
  end

  def train_change_speed(train_name_or_index, speed)
    train_index = get_index_of_obj_in_array(trains, train_name_or_index)
    trains[train_index].set_speed(speed)
  end

  def get_trains_on_station(station_name_or_index)
    staion_index = get_index_of_obj_in_array(stations, station_name_or_index)
    stations[staion_index].get_trains
  end

  def print_stations
    puts 'Stations list:'
    print_object_index_name(stations)
  end

  def print_trains
    puts 'Trains list:'
    print_trains_full_info(trains)
  end

  def print_routes
    puts 'Routes list:'
    print_object_index_name(routes)
  end

  def print_cars
    puts 'Cars list:'
    print_object_index_name(train_cars)
  end

  private

  attr_writer :trains, :stations, :routes, :train_cars

  def is_numeric?(input)
    # it seems to me that this method should be declared elsewhere, but, anyway, it's here for now :)

    Integer(input)
  rescue
    false
  end

  def get_obj_from_array_by_name(obj, name)
    # Is it possible to parametrize name? I mean, use ANY attribute, like with send("some_method_#{var}) example?
    obj.select { |item| item.name == name }.first
  end

  def get_index_of_obj_in_array(obj, attribute_name_or_index)
    if is_numeric?(attribute_name_or_index)
      attribute_name_or_index.to_i
    else
      obj.index(get_obj_from_array_by_name(obj, attribute_name_or_index))
    end
  end

  def get_train_obj_by_name(name)
    trains.select { |item| item.name == name }.first
  end

  def get_car_obj_by_name(name)
    train_cars.select { |item| item.name == name }.first
  end

  def get_station_obj_by_name(name)
    stations.select { |item| item.name == name }.first
  end

  def get_route_obj_by_name(name)
    routes.select { |item| item.name == name }.first
  end

  def create_train_cargo(id, name)
    trains << CargoTrain.new(id, name)
  end

  def create_train_passenger(id, name)
    trains << PassengerTrain.new(id, name)
  end

  def create_train_car_passenger(name, capacity)
    train_cars << PassengerCar.new(name, capacity)
  end

  def create_train_car_cargo(name, capacity)
    train_cars << CargoCar.new(name, capacity)
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

def manage_stations(super_main)
  puts '1. Create station. '
  puts '2. Get trains on station'
  puts '3. Delete station'
  puts '0. Back'
  case gets.chomp
  when '1'
    begin
      puts 'Enter station name'
      super_main.create_station(gets.chomp)
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('Station', e)
      retry
    end
  when '2'
    super_main.print_stations
    puts 'Enter station name'
    super_main.get_trains_on_station(gets.chomp)
  when '3'
    super_main.print_stations
    puts 'Enter station name'
    super_main.remove_station(gets.chomp)
  when '0'
    return
  end
end

def manage_routes(super_main)
  puts '1. Create route'
  puts '2. Add station to route'
  puts '3. Delete station from route'
  puts '0. Back'
  case gets.chomp
  when '1'
    begin
      super_main.print_stations
      puts 'Enter route name, first station, last station.'
      input = gets.chomp.split
      first_station = input[0]
      last_station = input[1]
      route_name = input[2]
      super_main.create_route(first_station, last_station, route_name)
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('Route', e)
      retry
    end
  when '2'
    super_main.print_stations
    super_main.print_routes
    puts 'Specify route name, station name, index where to insert new station (if none specified - will be inserted as previous to end).'
    input = gets.chomp.split
    route = input[0]
    station = input[1]
    position = input[2]
    super_main.add_station_to_route(route, station, position)
  when '3'
    super_main.print_routes
    super_main.print_stations
    puts 'Specify route to work with and station to delete from specified route'
    input = gets.chomp.split
    route_name = input[0]
    station_name = input[1]
    super_main.remove_station_from_route(route_name, station_name)
  when '0'
    return
  end
  super_main.print_routes
end

def manage_trains(super_main)
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
    begin
      super_main.print_cars
      puts 'Enter car name (id)'
      super_main.create_train_car(gets.chomp, 'passenger')
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('PassengerTrainCar', e)
      retry
    end
  when '2'
    begin
      super_main.print_cars
      puts 'Enter car name (id)'
      super_main.create_train_car(gets.chomp, 'cargo')
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('CargoTrainCar', e)
      retry
    end
  when '3'
    begin
      puts 'Enter train id, train name, delimeted with space.'
      id, name = gets.chomp.split
      super_main.create_train(id, name, 'passenger')
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('PassengerTrain', e)
      retry
    end
  when '4'
    begin
      puts 'Enter train name, id delimeted with space.'
      id, name = gets.chomp.split
      super_main.create_train(id, name, 'cargo')
    rescue MyNastyValidators::ValidationError => e
      print_failed_to_create_object('CargoTrain', e)
      retry
    end
  when '5'
    super_main.print_trains
    super_main.print_cars
    puts 'Specify name of train and car name to add. Please keep in mind that for each train type the same car type must be used and train must be stopped at the moment.'
    train_name, car_name = gets.chomp.split
    super_main.train_add_car(train_name, car_name)
  when '6'
    super_main.print_routes
    super_main.print_trains
    puts 'Specify name or index of train and name or index of route to assign to'
    train_name, route_name = gets.chomp.split
    puts "TRAIN: #{train_name}, ROUTE #{route_name}"
    super_main.train_assign_route(train_name, route_name)
  when '7'
    super_main.print_trains
    super_main.print_routes
    super_main.print_stations
    puts 'Specify which train to move forward'
    super_main.train_move_forward(gets.chomp)
  when '8'
    super_main.print_stations
    puts 'Specify which train to move backward'
    super_main.train_move_backward(gets.chomp)
  when '9'
    super_main.print_trains
    puts 'Specify which train to stop'
    super_main.train_change_speed(gets.chomp, 0)
  when '10'
    super_main.print_trains
    puts 'Specifyg train name and speed'
    train_name, speed = gets.chomp.split
    super_main.train_change_speed(train_name, speed)
  when '0'
    return
  end
end

def create_and_print_test_data(super_main)
  json_file = File.open('../resources/test_data.json').read
  json = JSON.parse(json_file)
  puts "json is #{json['stations'].class}"
  json['stations'].each { |item| super_main.create_station(item['name']) }
  json['routes'].each { |item| super_main.create_route(item['name'], item['first_station'], item['last_station']) }
  json['trains'].each { |item| super_main.create_train(item['id'], item['name'], item['type']) }
  super_main.train_cars.select do |car|
    cargo_train = super_main.trains[0]
    passenger_train = super_main.trains[3]
    if car.is_a?(CargoCar)
      cargo_train.add_car(car)
    elsif car.is_a?(PassengerCar)
      passenger_train.add_car(car)
    end
  end

  super_main.train_cars[0].load_cargo(7)
  super_main.train_cars[1].load_cargo(22)
  super_main.train_cars[2].load_cargo(123.55)
  75.times { super_main.train_cars[3].add_passenger }
  8.times { super_main.train_cars[4].add_passenger }
  50.times { super_main.train_cars[5].add_passenger }

  # %w(cargo_train passenger_train).each { |train| train.assign_route(route) }
  super_main.trains.each { |train| train.assign_route(super_main.routes[0]); puts train.get_station }
  test_block(super_main)
end

def test_block(super_main)
  super_main.stations.each do |station|
    station.each_train do |train|
      puts train 
      train.cars do |car|
        puts car
      end
    end
  end
end

def print_failed_to_create_object(name, exception)
  puts "Failed to create object #{name}. Following type error occured #{exception.class} with message:\n#{exception.message}"
  puts 'Retrying...'
end

super_main = SuperMain.new
puts 'Lets go'
loop do
  puts '1. Manage stations'
  puts '2. Manage routes'
  puts '3. Manage trains'
  puts '4. Create test data and print it out'
  puts '0. Exit'
  case gets.chomp
  when '1'
    manage_stations(super_main)
  when '2'
    manage_routes(super_main)
  when '3'
    manage_trains(super_main)
  when '4'
    create_and_print_test_data(super_main)
  when '0'
    exit
  end
end
