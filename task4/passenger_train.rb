require_relative '../task3/train.rb'
class PassengerTrain < Train
  attr_reader :type 

  def initialize(*)
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

  def add_passenger(count = 1)
    change_capacity_usage unless self.capacity_usage(count) == self.capacity 
  end

  def remove_passenger(count = 1)
    change_capacity_usage(count * (-1)) unless self.capactiy_usage == 0 
  end
  protected
  def validate!
    super
  end
end
