#!/usr/bin/env python
'''
Generates a ruby controller test file to plant a grid of plants
'''
# default values
toolbayx = 150
toolbayy = 2010
toolbayz = -13550
seedbinz = -12245
plantx = 1000
planty = 1000
plantz = -14600
offsetx = 1000
offsety = 1000
gridrows = 2
gridcols = 4
clearx_toolout = 500
clearz_seedbin = 1000
clearz_toolbay = 4000
clearz_plant = 4000
vacuum_pump_pin = 10
water_pin = 9
watering_tool_bay_position = 1
seed_injector_tool_bay_position = 2
seedbin_bay_position = 4
watering_duration = 0.5
watering_circle_radius = 0
watering_points_on_circle = 4

def move_abs(x, y, z):
    test_file.write("HardwareInterface.current."
	                "move_to_coord({x}, {y}, {z})\n".format(x=x, y=y, z=z))

def write_pin(pin, value):
    test_file.write("HardwareInterface.current."
	                "pin_std_set_value({pin}, {value}, 0)\n".format(pin=pin,
					value=value))

# sequences
def pickuptool(bay):
    test_file.write("\n# Pickup Tool {no}\n".format(no=bay))
    Y_TOOL = toolbayy + (bay - 1) * 500
    move_abs(toolbayx, Y_TOOL, toolbayz + clearz_toolbay)
    move_abs(toolbayx, Y_TOOL, toolbayz)
    move_abs(toolbayx + clearx_toolout, Y_TOOL, toolbayz)
    move_abs(toolbayx + clearx_toolout, Y_TOOL, toolbayz + clearz_toolbay)

def water_plant():
    test_file.write("\n# Water grid location X{gridx} Y{gridy}\n".format(
		      gridx=(gridx + 1), gridy=(gridy + 1)))
    move_abs(currentplantx, currentplanty, plantz + clearz_plant)
    write_pin(water_pin, 1)
    test_file.write("sleep {watering_duration}\n".format(
		watering_duration=watering_duration))
    write_pin(water_pin, 0)

def water_around_plant():
    import numpy as np
    test_file.write("\n# Water around grid location X{gridx} Y{gridy}"
	                "using circle radius={r}\n".format(gridx=(gridx + 1),
					gridy=(gridy + 1), r=watering_circle_radius))
    move_abs(currentplantx - watering_circle_radius,
	         currentplanty, plantz + clearz_plant)
    theta = np.linspace(np.pi, 3 * np.pi, watering_points_on_circle)
    for t in theta:
        xc = currentplantx + watering_circle_radius * np.cos(t)
        yc = currentplanty + watering_circle_radius * np.sin(t)
        move_abs(xc, yc, plantz + clearz_plant)
        write_pin(water_pin, 1)
        test_file.write("sleep {watering_duration}\n".format(
			watering_duration=watering_duration))
        write_pin(water_pin, 0)

def getseed(bay):
    test_file.write("\n# Get seed\n")
    Y_TOOL = toolbayy + (bay - 1) * 500
    move_abs(toolbayx, Y_TOOL, seedbinz + clearz_seedbin)
    move_abs(toolbayx, Y_TOOL, seedbinz)
    write_pin(vacuum_pump_pin, 1)
    move_abs(toolbayx, Y_TOOL, seedbinz + clearz_seedbin)

def plant():
    test_file.write("\n# Plant seed at grid location"
	                "X{gridx} Y{gridy}\n".format(gridx=(gridx + 1),
					                             gridy=(gridy + 1)))
    move_abs(currentplantx, currentplanty, plantz + clearz_plant)
    move_abs(currentplantx, currentplanty, plantz)
    write_pin(vacuum_pump_pin, 0)
    move_abs(currentplantx, currentplanty, plantz + clearz_plant)

def returntool(bay):
    test_file.write("\n# Return Tool {no}\n".format(no=bay))
    Y_TOOL = toolbayy + (bay - 1) * 500
    move_abs(toolbayx + clearx_toolout, Y_TOOL, toolbayz + clearz_toolbay)
    move_abs(toolbayx + clearx_toolout, Y_TOOL, toolbayz)
    move_abs(toolbayx, Y_TOOL, toolbayz)
    move_abs(toolbayx, Y_TOOL, toolbayz + clearz_toolbay)

def home():
    test_file.write("\n# Home all axes\n")
    test_file.write("HardwareInterface.current.move_home_x()\n")
    test_file.write("HardwareInterface.current.move_home_y()\n")
    test_file.write("HardwareInterface.current.move_home_z()\n")

def go_to_home():
    test_file.write("\n# Go to home\n")
    move_abs(0, 0, 0)

print "=" * 63
print "Generates a ruby controller test file to plant a grid of plants"
print
print "-" * 52
print """Closest Toolbay Location (UTM Connection coordinate)
    X = {toolbayx}
    Y = {toolbayy}
    Z = {toolbayz}
Toolbay Positions
    Seed Injector = {seed_injector_tool_bay_position}
    Watering Tool = {watering_tool_bay_position}
    Seed Bin = {seedbin_bay_position}
Seed Bin Toolbay Location (coordinate of seeds)
    Z = {seedbinz}
First Plant Location (desired seed coordinate)
    X = {plantx}
    Y = {planty}
    Z = {plantz}
Plant Location Offset
    X = {offsetx}
    Y = {offsety}
Plant Grid
    number of plants along Y (ROWS) = {gridrows}
    number of plants along X (COLUMNS) = {gridcols}
Clearance moves
    X clearance amount tool out of toolbay = {clearx_toolout}
    Z clearance amount above tool bay = {clearz_toolbay}
    Z clearance amount above seedbin = {clearz_seedbin}
    Z clearance amount above plant location = {clearz_plant}
Pins
    Vacuum Pump = {vacuum_pump_pin}
    Water = {water_pin}
Watering
    Duration = {watering_duration} seconds
    Circle radius = {watering_circle_radius}
    Number of points in circle = {npic}""".format(toolbayx=toolbayx,
    toolbayy=toolbayy,
    toolbayz=toolbayz,
    seedbinz=seedbinz,
    plantx=plantx,
    planty=planty,
    plantz=plantz,
    offsetx=offsetx,
    offsety=offsety,
    gridrows=gridrows,
    gridcols=gridcols,
    clearx_toolout=clearx_toolout,
    clearz_toolbay=clearz_toolbay,
    clearz_seedbin=clearz_seedbin,
    clearz_plant=clearz_plant,
    vacuum_pump_pin=vacuum_pump_pin,
    seed_injector_tool_bay_position=seed_injector_tool_bay_position,
    watering_tool_bay_position=watering_tool_bay_position,
    seedbin_bay_position=seedbin_bay_position,
    water_pin=water_pin,
    watering_duration=watering_duration,
    watering_circle_radius=watering_circle_radius,
    npic=watering_points_on_circle)

print "-" * 50

seed = raw_input("Generate planting sequence?(Y/n)")
if 'y' in seed or 'Y' in seed:
    seed = 1
elif seed == '':
    seed = 1
else:
    seed = 0

water = raw_input("Generate watering sequence?(Y/n)")
if 'y' in water or 'Y' in water:
    water = 1
elif water == '':
    water = 1
else:
    water = 0

# output filename
if watering_circle_radius > 0:
    testfile_name = ("tf_S{seed}_W{water}_X{gridcols}_by_Y{gridrows}_grid_r{r}"
					"_n{n}_t{t}.rb".format(gridrows=gridrows, gridcols=gridcols,
									       seed=seed, water=water,
									       r=watering_circle_radius,
									       n=watering_points_on_circle,
									       t=watering_duration))
else:
    testfile_name = ("tf_S{seed}_W{water}_X{gridcols}_by_Y{gridrows}_grid_r{r}"
					 ".rb".format(gridrows=gridrows, gridcols=gridcols,
								  seed=seed, water=water,
								  r=watering_circle_radius))

print
if seed:
    print "Plant Seeds: YES"
else:
    print "Plant Seeds: NO"
if water:
    print "Water:       YES"
else:
    print "Water:       NO"

toolbay = {}
toolbay[seed_injector_tool_bay_position] = "Seed Injector"
toolbay[watering_tool_bay_position] = "Watering Tool"
toolbay[seedbin_bay_position] = "Seed Bin"
print
print "Toolbay:"
for i in range(5, 0, -1):
    try:
        print "    (\t{t}\t)".format(t=toolbay[i])
    except KeyError:
        print "    (\t{empty}\t)".format(empty=("-x-" + "  " * 5))

print "\nGrid:"
for row in range(0,gridrows):
    print "." * gridcols

create_file = raw_input("\nCreate file?(Y/n)")
if 'y' in create_file or 'Y' in create_file:
    pass
elif create_file == '':
    pass
else:
    raise SystemExit("\nExiting...no file created.\n")

with open(testfile_name, 'w') as test_file:
    test_file.write('''puts '[Controller Test File]'
puts 'starting up'

$hardware_sim = 0
$shutdown     = 0

require "./lib/hardware/gcode/ramps.rb"
HardwareInterface.current = HardwareInterface.new(false)

require_relative 'lib/status'
Status.current = Status.new

''')
    #home()

    if seed:
        pickuptool(seed_injector_tool_bay_position)
        for gridx in range(0, gridcols):
            for gridy in range(0, gridrows):
                currentplantx = plantx + gridx * offsetx
                currentplanty = planty + gridy * offsety
                getseed(seedbin_bay_position)
                plant()
        returntool(seed_injector_tool_bay_position)

    if water:
        pickuptool(watering_tool_bay_position)
        for gridx in range(0, gridcols):
            for gridy in range(0, gridrows):
                currentplantx = plantx + gridx * offsetx
                currentplanty = planty + gridy * offsety
                if watering_circle_radius > 0:
                    water_around_plant()
                else:
                    water_plant()
        returntool(watering_tool_bay_position)

    go_to_home()

print "\nTest file saved: {f}\n".format(f=testfile_name)
