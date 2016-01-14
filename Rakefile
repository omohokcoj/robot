require_relative 'lib/robot_simulator.rb'

app = RobotSimulator::Application.new

task :test, :file do |t, args|
  p app.perform_script(args[:file]) if args[:file]
end
