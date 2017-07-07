require_relative '../task5/company.rb'
require_relative '../task6/my_nasty_validators.rb'
class TrainCar
  include Company
  include MyNastyValidators
  attr_reader :name, :capacity, :capacity_used, :id, :type
  NAME_FORMAT_REGEXP = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
  NAME_MIN_LENGTH = 3
  CAPACITY_ACTIONS_ALLOWED = %w[increase decrease].freeze

  def initialize(name, capacity)
    puts "You put: #{name}, #{capacity}"
    @id = rand(10**10).to_s(10)
    @name = name
    @capacity = capacity
    @capacity_used = 0
    @type = self.class.to_s
    validate!
  end

  def valid?
    validate!
    true
  rescue MyNastyValidators::ValidationError
    false
  end

  def capacity_free
    capacity - capacity_used
  end

  def to_s
    "name: #{name}, capacity: #{capacity}, type: #{type}"
  end

  protected

  attr_reader :capacity_type
  attr_writer :capacity, :capacity_used

  def change_capacity_usage(action, amount = 1) # action = [increase, decrease]
    raise "Only #{CAPACITY_ACTIONS_ALLOWED} allowed" unless CAPACITY_ACTIONS_ALLOWED.include?(action)
    send("#{action}_capacity_usage", amount)
  end

  def increase_capacity_usage(amount)
    if capacity_used + amount > capacity
      raise "Capacity usage could not be more that #{capacity}. Current capacity usage #{capacity_used}"
      # self.capacity_used += amount
      @capacity_used += amount
    end
  end

  def decrease_capacity_usage(amount)
    if capacity_used + amount < 0
      raise "Capacity usage coult not be less the 0. Current capacity usage #{capacity_used}"
    end
    self.capacity_used += -amount
  end

  def validate!
    validate_format!(@name, NAME_FORMAT_REGEXP)
    validate_length!(@name, NAME_MIN_LENGTH)
    raise 'Capacity must be > 0' if @capacity < 0
  end
end
