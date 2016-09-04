puts '[Controller Test File]'
puts 'starting up'

$hardware_sim = 0
$shutdown     = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new

HardwareInterface.current.move_to_coord(14000, 0, 0)
HardwareInterface.current.move_to_coord(0, 0, 0)
