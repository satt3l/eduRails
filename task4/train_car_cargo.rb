require_relative 'train_car.rb'
class CargoCar < TrainCar
  def load_cargo(amount = 1)
    change_capacity_usage('increase', amount)
  end

  def unload_cargo(amount = 1)
    change_capacity_usage('decrease', amount)
  end

  protected

  def validate!
    super
    raise 'Capacity must be type of Float' unless capacity.is_a?(Numeric)
  end
end
