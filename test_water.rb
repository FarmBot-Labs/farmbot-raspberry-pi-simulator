puts '[Controller Test File]'
puts 'starting up'

$hardware_sim = 0
$shutdown     = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new


HardwareInterface.current.pin_std_set_value(9, 1, 0)
sleep 2
HardwareInterface.current.pin_std_set_value(9, 0, 0)
