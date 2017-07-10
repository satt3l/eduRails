require_relative '../task6/my_nasty_validators.rb'

class Route
  include MyNastyValidators

  attr_reader :stations, :name
  NAME_FORMAT_REGEXP = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
  NAME_MIN_LENGTH = 3

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    validate!
    [first_station, last_station].each { |station| raise "Stations must be instance of class Station, you give #{station.class}" unless station.is_a?(Station) }
    puts "Object created successfully: #{self}"
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
    if index >= stations.size
      stations.last
    elsif index < 0
      stations.first
    else
      stations[index]
    end
  end

  protected

  def validate!
    validate_format!(@name, NAME_FORMAT_REGEXP)
    validate_length!(@name, NAME_MIN_LENGTH)
  end
end
