puts '[FarmBot Controller Menu]'
puts 'starting up'

$hardware_sim = 0
$shutdown    = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new

while $shutdown == 0 do

#  system('clear')

#  puts '[FarmBot Test]'
#  puts ''

#  puts ''
  HardwareInterface.current.ramps_arduino.test_read_init()
  #sleep 0.5
  HardwareInterface.current.ramps_arduino.test_read_once()

  #HardwareInterface.current.pin_std_set_mode(13, mode)


  sleep 1.5

  puts 'press a key to continue...'
  gets


  HardwareInterface.current.pin_std_set_value(13, 1, 0) # write a one in digital mode


  puts 'press a key to continue...'
  gets


  HardwareInterface.current.pin_std_set_value(13, 0, 0) # write a zero in digital mode




  #HardwareInterface.current.calibrate_x()

  #HardwareInterface.current.move_to_coord(100, 0, 0)
  #puts "waiting"
  #sleep 1
  #HardwareInterface.current.move_to_coord(  0, 0, 0)

  #HardwareInterface.current.write_param_value( 0,0) # parameter version

  #HardwareInterface.current.write_param_value( 0,121) # parameter version
  #HardwareInterface.current.write_param_value(11,122) # parameter version
  #HardwareInterface.current.write_param_value(12,123) # parameter version
  #HardwareInterface.current.write_param_value(13,124) # parameter version
  #HardwareInterface.current.write_param_value(71,4001) # parameter version
  #HardwareInterface.current.write_param_value(72,4002) # parameter version
  #HardwareInterface.current.write_param_value(73,4003) # parameter version

  #sleep 1
  #HardwareInterface.current.read_all_params()


  #HardwareInterface.current.write_param_value(101,0) # enable encoder x
  #HardwareInterface.current.write_param_value(111,70) # missed steps max x
  #HardwareInterface.current.write_param_value(121,2) # decay x




  #HardwareInterface.current.calibrate_x()
  #sleep 1
  #HardwareInterface.current.move_home_x()



  #HardwareInterface.current.move_home_x()
  #sleep 1
  #HardwareInterface.current.move_to_coord(1000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(2000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(3000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(2000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(1000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(   0, 0, 0)
  #sleep 1

  #HardwareInterface.current.move_to_coord(4000, 0, 0)
  #puts 'wait'
  #sleep 2

  #HardwareInterface.current.move_to_coord(0, 0, 0)
  #puts 'wait'
  #sleep 2

  #HardwareInterface.current.move_home_x()



  #HardwareInterface.current.move_to_coord( 50, 0, 0)



  #puts 'press a key to continue...'
  #gets

  #HardwareInterface.current.write_param_value(101,0) # enable encoder x
  #HardwareInterface.current.write_param_value(111,70) # missed steps max x
  #HardwareInterface.current.write_param_value(121,2) # decay x
  #sleep 2
  #sleep 2


  #HardwareInterface.current.move_home_x()
  #puts 'wait'
  #sleep 2


  #HardwareInterface.current.move_to_coord(500, 0, 0)
  #HardwareInterface.current.move_relative(20, 0, 0)
  #HardwareInterface.current.move_relative(100, 0, 0)
  #HardwareInterface.current.move_relative(1000, 0, 0)
  #HardwareInterface.current.move_relative(4000, 0, 0)
  
  #puts 'wait'
  #sleep 2



  #HardwareInterface.current.move_relative(0, 0, 0)
  #HardwareInterface.current.move_relative(0, 10, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(0, 1000, 0)
  #HardwareInterface.current.move_to_coord(0, 6000, 0)
  #sleep 1
  #HardwareInterface.current.move_to_coord(0, 10, 0)

  #HardwareInterface.current.move_to_coord(6000, 0, 0)
  #HardwareInterface.current.move_to_coord(500, 0, 0)
  #HardwareInterface.current.move_to_coord(6500, 0, 0)
  
  #sleep 2
  #HardwareInterface.current.move_home_x()

###################################################
  #sleep 2
  ## ## HardwareInterface.current.calibrate_x()

  #sleep 1
  #HardwareInterface.current.move_to_coord(5000, 0, 0)
  #HardwareInterface.current.move_relative(1000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_relative(1000, 0, 0)
  #sleep 1
  #HardwareInterface.current.move_relative(1000, 0, 0)


  #sleep 1
  #HardwareInterface.current.move_home_x()
  #HardwareInterface.current.move_to_coord(0, 0, 0)

  #HardwareInterface.current.move_relative(-10, 0, 0)
  #HardwareInterface.current.move_relative(-4000, 0, 0)
  #HardwareInterface.current.move_relative(0, -10, 0)
  #HardwareInterface.current.move_relative(0, -1000, 0)

  #sleep 1
  #HardwareInterface.current.move_to_coord(500, 0, 0)
  ##HardwareInterface.current.move_to_coord( 50, 0, 0)
  #sleep 1
  ##HardwareInterface.current.move_to_coord(  0, 0, 0)

  #sleep 1
  #HardwareInterface.current.move_home_x()

  #puts "reading"
  #HardwareInterface.current.ramps_arduino.test_read_init()
  #while(true)
  #  HardwareInterface.current.ramps_arduino.test_read_once()
  #end

  #HardwareInterface.current.move_home_x()


  #sleep 0.5
  #HardwareInterface.current.move_to_coord(1000, 0, 0)

  #sleep 0.5
  #HardwareInterface.current.ramps_arduino.test_read_init()
  #sleep 0.5
  #HardwareInterface.current.ramps_arduino.test_read_once()

  #sleep 0.5
  #HardwareInterface.current.move_to_coord(0, 0, 0)

  #sleep 0.5
  #HardwareInterface.current.ramps_arduino.test_read_init()
  #sleep 0.5
  #HardwareInterface.current.ramps_arduino.test_read_once()


#  puts ''
#  puts 'press a key to continue...'
#  gets

end
