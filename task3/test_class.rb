require './Route.rb'
require './Station.rb'
require './Train.rb'


a1 = Station.new('a1')
a2 = Station.new('a2')
a3 = Station.new('a3')
a4 = Station.new('a4')

b1 = Station.new('b1')
b2 = Station.new('b2')
b3 = Station.new('b3')
b4 = Station.new('b4')

ra1 = Route.new(a1, a4)
rb1 = Route.new(b1, b4)

tr1 = Train.new('tr1', 'passenger', 5, false)
tr2 = Train.new('tr2', 'passenger', 1, false)
tr3 = Train.new('tr3', 'passenger', 0)
tr4 = Train.new('tr4', 'goods', 28)
tr5 = Train.new('tr5', 'goods', 99998)
tr6 = Train.new('tr6', 'goods', 28)
tr7 = Train.new('tr7', 'goods', 0)

# Routes test
# Add new station
ra1.add_station(a2)
ra1.add_station(a3)
ra1.get_stations
puts "--------------------"
rb1.add_station(b3)
rb1.get_stations
puts "--------------------"
rb1.add_station(b2, 1)
rb1.get_stations
puts "--------------------"
# Remove station by name
rb1.remove_station(b3)
# List all stations
rb1.get_stations
puts "--------------------"
# Train test
# Can show id and type show car amount, can move on route forward and backward,
[tr1, tr3, tr5, tr7].each do |tr| 
  puts "Train id: #{tr.id}, train type: #{tr.type}, amount of cars: #{tr.car_count}, current speed: #{tr.speed}"
  tr.gain_speed(120)
  tr.assign_route(ra1)
  tr.move_forward
  tr.move_forward
  tr.move_backward
end
tr1.move_backward
tr3.move_forward
tr3.move_forward
tr5.assign_route(rb1)
50.times{ tr7.move_forward}

puts '-----GET TRAINS----'
[a1, a2, a3, a4].each{|a| a.get_trains}

[tr2, tr4, tr6].each do |tr| 
  puts "Train id: #{tr.id}, train type: #{tr.type}, amount of cars: #{tr.car_count}, current speed: #{tr.speed}"
  tr.gain_speed(90)
  tr.assign_route(rb1)
  tr.move_forward
  tr.move_forward 
  tr.get_station
end
[b1, b2, b3, b4].each{|b| b.get_trains('goods')}
# Can show current speed.
tr1.gain_speed(70)
puts tr1.speed

puts 'END ----- get TRAINs ----'
# Can stop 
tr1.stop
puts tr1.speed
# Can change amount of cars ONLY if not moving
tr2.gain_speed(120)
tr2.add_car
tr2.del_car
tr2.stop
tr2.add_car
tr2.del_car

# Can pick a route
tr3.assign_route(ra1)
puts tr3.route
puts tr3.route_position
puts tr3.get_station
# can show next, current, previous stations
tr3.move_forward
puts tr3.get_station # current
puts tr3.get_station('next')
puts tr3.get_station('previous') 

