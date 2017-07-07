require_relative '../task3/train.rb'
class PassengerTrain < Train
  attr_reader :type

  def initialize(*)
    super
    @type = 'passenger'
  end

  def add_car(train_car)
    # need to know specifical name of train car class
    car_list << train_car if train_car.is_a?(PassengerCar) && super
  end

  def remove_car(train_car)
    car_list.delete(train_car) if !car_list.size.zero? && super
  end

  protected

  def validate!
    super
  end
end
