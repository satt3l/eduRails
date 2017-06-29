require_relative '../task5/company.rb'
require_relative '../task6/my_nasty_validators.rb'
class TrainCar
  include Company
  include MyNastyValidators
  attr_reader :name, :capacity, :capacity_used, :id
  NAME_FORMAT_REGEXP = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
  NAME_MIN_LENGTH = 3

  def initialize(name, capacity)
    puts "You put: #{name}, #{capacity}"
    @id = rand(10**10).to_s(10)
    @name = name
    @capacity = capacity
    @capacity_used = 0
    validate!
  end

  def valid?
    validate!
    true
    rescue MyNastyValidators::ValidationError
      false
  end

  def capacity_free
    self.capacity - self.capacity_used
  end

  protected
  attr_reader :capacity_type
  attr_writer :capacity, :capacity_used

  def change_capacity_usage(amount = 1)
    if self.capacity_used + amount < 0
      raise "Capacity usage coult not be less the 0. Current capacity usage #{self.capacity_used}"
    elsif self.capacity_used + amount > self.capacity
      railse "Capacity usage could not be more that #{self.capacity}. Current capacity usage #{self.capacity_used}"
    else
      self.capacity_used += amount
    end
  end

  def validate!
    validate_format!(@name, NAME_FORMAT_REGEXP)
    validate_length!(@name, NAME_MIN_LENGTH)
    raise 'Capacity must be > 0' if @capacity < 0
  end

end
