require_relative '../task3/train.rb'
class CargoTrain < Train
  attr_reader :car_list

  def initialize(name)
    super
    @type = 'cargo'
    @car_list = []
  end 

  def add_car(train_car)
    self.car_list << train_car if (train_car.is_a?(CargoTrainCar) and self.speed == 0) 
  end

  def remove_car(train_car)
    self.car_list.delte(train_car) if (self.car_list.size != 0 and self.speed == 0)
  end

  private
  attr_writer :car_list

end

