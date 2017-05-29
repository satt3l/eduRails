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

tr1 = Train.new('tr1', 'passenger', 5, true)
tr2 = Train.new('tr2', 'passenger', 1, true)
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
rb1.add_station(b3)
rb1.add_station(b2, 1)
rb1.get_stations
rb1.remove_station(b3)
rb1.get_stations
# Remove station by name
# List all stations
# Train test
# Can show id and type show car amount
[tr1, tr2, tr3, tr4, tr5, tr6, tr7].each {|tr| puts "Train id: #{tr.id}, train type: #{tr.type}, amount of cars: #{tr.car_count}, current speed: #{tr.speed}"}
# Can show current speed.
tr1.gain_speed(70)
puts tr1.speed

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

# Cass pick a route
tr3.assign_route(ra1)
puts tr3.route
puts tr3.route_position
puts tr3.get_station
# Can move forward and backward on route
tr3.move_forward
puts tr3.get_station # current
puts tr3.get_station('next')
puts tr3.get_station('previous') 
# Can show next, previous, current station
# Station test
a2.get_trains
# List all trains on station
# List All goods trains on station
# List All passeger trains on station
#

