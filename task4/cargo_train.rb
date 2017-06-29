require_relative '../task3/train.rb'
class CargoTrain < Train
  attr_reader :type 
  def initialize(*)
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

  def add_cargo(amount = 1)
     change_capacity_usageunless self.capacity_usage == self.capacity
  end

  def remove_cargo(amount = 1)
     change_capacity_usage(amount * (-1)) unless self.capacity_usage == 0
  end
  protected
  def validate!
    super
  end
end

