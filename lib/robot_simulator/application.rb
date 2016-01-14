module RobotSimulator
  class Application
    def initialize
      board = Board.new
      @robot = Robot.new(board)
    end

    def perform_script(path)
      File.open(path, 'r').each_line { |line| parse line }
      @robot.report
    end

    private

    def parse(line)
      command = line[/^(PLACE|MOVE|LEFT|RIGHT)/]
      if command
        args = line.gsub(command, '').split(',').map(&:strip).reject(&:empty?)
        @robot.send(command.downcase, *args)
      end
    end
  end
end
