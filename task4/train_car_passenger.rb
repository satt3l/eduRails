require_relative 'train_car.rb'
class PassengerTrainCar < TrainCar

  def add_passenger(amount = 1)
    change_capacity_usage(amount) 
  end

  def remove_passenger(amount = 1)
    change_capacity_usage(amount * (-1)) 
  end

  protected

  def validate!
    super
    raise "Capacity must be type of Fixnum" unless self.capacity.is_a?(Fixnum)
  end
end
