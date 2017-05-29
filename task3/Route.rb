class Route
  attr_reader :stations
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end 

  def add_station(station, position = -2) 
    @stations.insert(position, station)
  end

  def remove_station(name)
    @stations.delete(name)  
  end

  def get_stations
    @stations.each_with_index do |station, index|
      puts "Position:#{index}, Name:#{station.name}"
    end
  end
  def get_station(index)
    if index > self.stations_size 
      return self.stations.last
    elsif index < 0
      return self.stations.first
    else
      return self.stations[index]
    end
  end
end	
