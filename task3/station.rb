require_relative '../task5/instance_counter.rb'
require_relative '../task6/my_nasty_validators.rb'

class Station
#  attr_reader :trains
  include InstanceCounter
  include MyNastyValidators
  attr_reader :name
  attr_accessor :trains
  NAME_FORMAT_REGEXP = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
  NAME_MIN_LENGTH = 3
  @@all_stations = [] 

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self 
    puts "Object created successfully: #{self}"
#    register_instance
  end

  def train_leave(train)
    @trains.delete(train)
  end

  def train_enter(train)
    self.trains << train
  end

  def get_trains(train_type = nil)
    result = []
    @trains.each do |train|
      result << train if (train_type.nil? or train_type == train.type) # I know, no need for brackets, just want to stress that these expressions connected
    end
    puts "Trains on station #{self.name}: #{result}, \nOverall trains of specified type are: #{result.size}"
    return result
  end

  def valid?
    validate!
    true
    rescue MyNastyValidators::ValidationError
      false
  end

  protected

  def validate!
    validate_format!(@name, NAME_FORMAT_REGEXP)
    validate_length!(@name, NAME_MIN_LENGTH)
  end
  
end
