class Route
  attr_reader :stations, :name
  def initialize(first_station, last_station, name)
    @stations = [first_station, last_station]
    @name = name
  end 

  def add_station(station, position = -2) 
    @stations.insert(position, station)
  end

  def remove_station(station)
    @stations.delete(station)  
  end

  def get_stations
    @stations.each_with_index do |station, index|
      puts "Position:#{index}, Name:#{station.name}"
    end
  end
  def get_station(index)
    if index >= self.stations.size 
      return self.stations.last
    elsif index < 0
      return self.stations.first
    else
      return self.stations[index]
    end
  end
end	
