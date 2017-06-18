require_relative '../task5/company.rb'
class TrainCar
  include Company
  attr_reader :name

  def initialize(name)
    @name = name
  end

end
