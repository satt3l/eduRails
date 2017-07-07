require_relative 'train_car.rb'
class PassengerCar < TrainCar
  def add_passenger(amount = 1)
    change_capacity_usage('increase', amount)
  end

  def remove_passenger(amount = 1)
    change_capacity_usage('decrease', amount)
  end

  protected

  def validate!
    super
    raise 'Capacity must be type of Fixnum' unless capacity.is_a?(Integer)
  end
end
