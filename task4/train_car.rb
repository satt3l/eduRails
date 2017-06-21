require_relative '../task5/company.rb'
require_relative '../task6/my_nasty_validators.rb'
class TrainCar
  include Company
  include MyNastyValidators
  attr_reader :name

  def initialize(name)
    @name = name
  end
  protected
  def valid!
    validate_name!(@name)
  end

end
