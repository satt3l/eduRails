require_relative '../task3/train.rb'
class PassengerTrain < Train
  def initialize(id, name)
    super
    @type = 'passenger'
  end

  def add_car(train_car)
    # need to know specifical name of train car class
    if train_car.is_a?(PassengerTrainCar) and super
      self.car_list << train_car
    end
  end
  
  def remove_car(train_car)
    if self.car_list.size != 0 and super
      self.car_list.delete(train_car)
    end
  end
end
