class Route
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end 
  def add_station(name, position = -2) 
    @stations.insert(position, name)
  end
  def remove_station(name)
    @trains.delete(name)  
  end
  def get_stations
    @stations.each_with_index do |index, station|
      puts "Position:#{index}, Name:#{station}"
    end
  end
end	
