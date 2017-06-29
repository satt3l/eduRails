require_relative 'train_car.rb'
class CargoTrainCar < TrainCar

  def load_cargo(amount = 1)
    change_capacity_usage(amount) 
  end

  def unload_cargo(amount = 1)
     change_capacity_usage(amount * (-1))
  end
  
  protected
  def validate!
    super
    raise "Capacity must be type of Float" unless self.capacity.is_a?(Float)
  end
end
