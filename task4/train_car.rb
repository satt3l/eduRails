require_relative '../task5/company.rb'
require_relative '../task6/my_nasty_validators.rb'
class TrainCar
  include Company
  include MyNastyValidators
  attr_reader :name
  NAME_FORMAT_REGEXP = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
  NAME_MIN_LENGTH = 3

  def initialize(name)
    @name = name
    validate!
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
