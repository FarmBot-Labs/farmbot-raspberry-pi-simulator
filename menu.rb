puts '[FarmBot Controller Menu]'
puts 'starting up'

$hardware_sim = 0
$shutdown    = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new

#run_command_line

# just a little menu for testing


$move_size      = 10
$command_delay  = 0
$pin_nr         = 13
$servo_angle    = 0

=begin
while $shutdown == 0 do

  #system('cls')
  system('clear')

  puts '[FarmBot Controller Menu]'
  puts ''
  puts 't - execute test'
  puts ''
  puts "move size = #{$move_size}"
  puts "command delay = #{$command_delay}"
  puts "pin nr = #{$pin_nr}"
  puts "servo angle = #{$servo_angle}"
  puts ''
  puts 'w - forward'
  puts 's - back'
  puts 'a - left'
  puts 'd - right'
  puts 'r - up'
  puts 'f - down'
  puts ''
  puts 'z - home z axis'
  puts 'x - home x axis'
  puts 'c - home y axis'
  puts ''
  puts 'y - dose water'
  puts 'u - set pin on'
  puts 'i - set pin off'
  puts 'k - move servo (pin 4,5)'
  puts ''
  puts 'q - step size'
  puts 'g - delay seconds'
  puts 'p - pin nr'
  puts 'j - servo angle (0-180)'
  puts ''
  print 'command > '
  input = gets
  puts ''

  case input.upcase[0]
#    when "P" # Quit
#      $shutdown = 1
#      puts 'Shutting down...'
    when "O" # Get status
      puts 'Not implemented yet. Press \'Enter\' key to continue.'
      gets
    when "J" # Set servo angle
      print 'Enter new servo angle > '
      servo_angle_temp = gets
      $servo_angle = servo_angle_temp.to_i if servo_angle_temp.to_i >= 0
    when "Q" # Set step size
      print 'Enter new step size > '
      move_size_temp = gets
      $move_size = move_size_temp.to_i if move_size_temp.to_i > 0
    when "G" # Set step delay (seconds)
      print 'Enter new delay in seconds > '
      command_delay_temp = gets
      $command_delay = command_delay_temp.to_i if command_delay_temp.to_i > 0
    when "P" # Set pin number
      print 'Enter new pin nr > '
      pin_nr_temp = gets
      $pin_nr = pin_nr_temp.to_i if pin_nr_temp.to_i > 0
    when "K" # Move Servo
      HardwareInterface.current.servo_move($pin_nr, $servo_angle)
    when "I" # Set Pin Off
      HardwareInterface.current.pin_write($pin_nr, 0)
    when "U" # Set Pin On
      HardwareInterface.current.pin_write($pin_nr, 1)
#    when "Y" # Dose water
#      HardwareInterface.current.pin_write($pin_nr, 1)
    when "Z" # Move to home
      HardwareInterface.current.home_z()
    when "X" # Move to home
      HardwareInterface.current.home_x()
    when "C" # Move to home
      HardwareInterface.current.home_x()
    when "W" # Move forward
      HardwareInterface.current.move_relative(0,$move_size, 0)
    when "S" # Move back
      HardwareInterface.current.move_relative(0,-$move_size, 0)
    when "D" # Move right
      HardwareInterface.current.move_relative($move_size, 0, 0)
    when "A" # Move left
      HardwareInterface.current.move_relative(-$move_size, 0, 0)
    when "R" # Move up
      HardwareInterface.current.move_relative(0, 0, $move_size)
    when "F" # Move down
      HardwareInterface.current.move_relative(0, 0, -$move_size)
    end

  puts ''
  puts 'press a key to continue...'
  gets

end
=end

while $shutdown == 0 do

  system('clear')

  puts '[FarmBot Test]'
  puts ''

  puts ''
  puts 'press a key to continue...'
  gets

  HardwareInterface.current.move_relative(100, 0, 0)
  sleep 1
  HardwareInterface.current.move_relative(0, 0, 0)

  puts ''
  puts 'press a key to continue...'
  gets

end
