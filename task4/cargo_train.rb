require_relative '../task3/train.rb'
class CargoTrain < Train

  def initialize(name)
    super
    @type = 'cargo'
  end 

  protected

  def add_car_to_train(train_car)
    self.car_list << train_car if (train_car.is_a?(CargoTrainCar) and self.speed == 0) 
  end

  def remove_car_from_train(train_car)
    self.car_list.delte(train_car) if (self.car_list.size != 0 and self.speed == 0)
  end

end

