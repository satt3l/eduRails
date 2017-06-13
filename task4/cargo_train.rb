require_relative '../task3/train.rb'
class CargoTrain < Train

  def initialize(name)
    super
    @type = 'cargo'
  end 

  def add_car(train_car)
    if train_car.is_a?(CargoTrainCar) and super
      self.car_list << train_car
    end
  end

  def remove_car_from_train(train_car)
    if self.car_list.size != 0 and super
      self.car_list.delete(train_car)
    end
  end

end

