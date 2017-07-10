require_relative '../task3/train.rb'
class CargoTrain < Train
  attr_reader :type
  def initialize(*)
    super
    @type = 'cargo'
  end

  def add_car(train_car)
    car_list << train_car if train_car.is_a?(CargoCar) && super
  end

  def remove_car_from_train(train_car)
    car_list.delete(train_car) if !car_list.empty? && super
  end

  def add_cargo(_amount = 1)
    change_capacity_usageunless capacity_usage == capacity
  end

  def remove_cargo(amount = 1)
    change_capacity_usage(amount * -1) unless capacity_usage.zero?
  end
end
