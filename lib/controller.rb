require 'active_record'
require 'date'
require_relative 'database/dbaccess'
require_relative 'controller_command_proc'
# FarmBot Controller: This module executes the schedule. It reads the next
# command and sends it to the hardware implementation
class Controller

  def initialize
    @star_char           = 0

    @bot_dbaccess        = DbAccess.current
    @last_hw_check       = Time.now
    @command             = nil

    @cmd_proc            = ControllerCommandProc.new
    @cmd_last_refresh    = 0
  end

  def runFarmBot

    startup_farmbot

    while $shutdown == 0 do

      begin

        # keep checking the database for new data
        get_next_command
        check_and_execute_command

      rescue => e
        puts("Error in controller\n#{e.message}\n#{e.backtrace.inspect}")
        @bot_dbaccess.write_to_log(1,"Error in controller\n#{e.message}\n#{e.backtrace.inspect}")
      end
    end
  end

  def check_and_execute_command
    if @command != nil and Status.current.emergency_stop == false
      Status.current.info_command_next = @command.scheduled_time
      check_command_execution_time
    else
      wait_for_next_command
    end
  end

  def check_command_execution_time
    # check the next command
    if @command.scheduled_time <= Time.now or command.scheduled_time == nil
      # if a valid command is found and the scheduled time has arrived, execute command
      execute_command
    else
      wait_for_scheduled_time
    end
  end

  def startup_farmbot

    Status.current.info_status = 'starting'
    puts 'OK'

    print 'arduino         '
    sleep 1
#    HardwareInterface.current.read_device_version() if $hardware_sim == 0
#    puts  Status.current.device_version

#    Status.current.info_status = 'synchronizing arduino parameters'
#    print 'parameters      '
#    HardwareInterface.current.check_parameters if $hardware_sim == 0
#    HardwareInterface.current.check_parameters if $hardware_sim == 0

#    if $hardware_sim == 0
#      if  HardwareInterface.current.ramps_param.params_in_sync
#        puts 'OK'
#      else
#        puts 'ERROR'
#      end
#    else
#      puts "SIM"
#    end

    #HardwareInterface.current.read_end_stops()
    #HardwareInterface.current.read_postition()
    read_hw_status()

    @bot_dbaccess.write_to_log(1,'Controller running')
    check = @bot_dbaccess.check_refresh

  end

  def get_next_command

    if Status.current.emergency_stop == false
      Status.current.info_status = 'checking schedule'
      #show_info()

      @command = @bot_dbaccess.get_command_to_execute
      @bot_dbaccess.save_refresh

    end
  end

  def execute_command

    # execute the command now and set the status to done
    Status.current.info_status = 'executing command'
    #show_info()


    Status.current.info_nr_of_commands = Status.current.info_nr_of_commands + 1

    process_command( @command )
    @bot_dbaccess.set_command_to_execute_status('FINISHED')
    Status.current.info_command_last = Time.now
    Status.current.info_command_next = nil

  end

  def wait_for_scheduled_time

    Status.current.info_status = 'waiting for scheduled time or refresh'

    refresh_received = false

    wait_start_time = Time.now

    # wait until the scheduled time has arrived, or wait for a minute or
    # until a refresh it set in the database as a sign new data has arrived

    while Time.now < wait_start_time + 60 and @command.scheduled_time > Time.now - 1 and refresh_received == false

      sleep 0.2
      check_hardware()
      refresh_received = check_refresh or @db_access.check_refresh

    end
  end

  def wait_for_next_command

    if Status.current.emergency_stop == true

      Status.current.info_status = 'emergency stop'
      sleep 0.5
      check_hardware()

    else

      Status.current.info_status = 'Awaiting commands.'

      @info_command_next = nil

      refresh_received = false
      wait_start_time = Time.now

      # wait for a minute or until a refresh it set in the database as a sign
      # new data has arrived

      while  Time.now < wait_start_time + 60 and refresh_received == false
        sleep 0.1
        check_hardware()

        refresh_received = true if @bot_dbaccess.check_refresh
        refresh_received = true if check_refresh

      end
    end
  end

  def process_command( cmd )

    @cmd_proc.process_command(cmd)
    read_hw_status()
    Status.current.info_movement = 'idle'

  end

  def check_hardware()

    if (Time.now - @last_hw_check) > 0.5 and $hardware_sim == 0
      #HardwareInterface.current.check_parameters
      HardwareInterface.current.read_end_stops()
      #HardwareInterface.current.read_postition()

      100.times do
        HardwareInterface.current.ramps_arduino.serial_char()
      end

      read_hw_status()
      @last_hw_check = Time.now

      print_star()
    end
  end

  def read_hw_status()

    print_hw_status()

  end

  def print_hw_status()

    100.times do
      print "\b"
    end

    print "x %04d %s%s " % [Status.current.info_current_x, bool_to_char(Status.current.info_end_stop_x_a), bool_to_char(Status.current.info_end_stop_x_b)]
    print "y %04d %s%s " % [Status.current.info_current_y, bool_to_char(Status.current.info_end_stop_y_a), bool_to_char(Status.current.info_end_stop_y_b)]
    print "z %04d %s%s " % [Status.current.info_current_z, bool_to_char(Status.current.info_end_stop_z_a), bool_to_char(Status.current.info_end_stop_z_b)]
    print ' '

  end

  def bool_to_char(value)
    if value
      return '*'
    else
      return '-'
    end
  end

  def print_star
    @star_char += 1
    @star_char %= 4
    print "\b"

    if Status.current.emergency_stop == true
      print 'E'
    else
      case @star_char
      when 0
        print '-'
      when 1
        print '\\'
      when 2
        print '|'
      when 3
        print '/'
      end
    end
  end

  def check_refresh
    if Status.current.command_refresh != @cmd_last_refresh
      refreshed = true
      @cmd_last_refresh = Status.current.command_refresh
    else
      refreshed = false
    end
    refreshed
  end

end
