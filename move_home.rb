puts '[Controller Test File]'
puts 'starting up'

$hardware_sim = 0
$shutdown     = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new


# Home all axes
#HardwareInterface.current.move_home_x()
#HardwareInterface.current.move_home_y()
#HardwareInterface.current.move_home_z()

# Go to home
HardwareInterface.current.move_to_coord(0, 0, 0)
