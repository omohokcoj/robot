module RobotSimulator
  PlacingError = Class.new(StandardError)

  class Robot
    MOVE_RULES = {
      north: [0, 1],
      east:  [1, 0],
      south: [0, -1],
      west:  [-1, 0]
    }

    attr_reader :board

    def initialize(board)
      @board = board
    end

    def place(x = 0, y = 0, f = :north)
      self.position  = Position.new(x.to_i, y.to_i)
      self.direction = f.downcase.to_sym
    end

    def left
      rotate(-1)
    end

    def right
      rotate 1
    end

    def move
      perform_safe do
        current_move = next_position
        self.position = current_move if current_move
      end
    end

    def report
      perform_safe do
        [*@position.coordinates, @direction.upcase].join(',')
      end
    end

    private

    def perform_safe
      if placed?
        yield
      else
        fail PlacingError, 'You should place robot at first'
      end
    end

    def placed?
      @position && @direction
    end

    def rotate(opt)
      perform_safe do
        index = avaliable_direction.index @direction
        self.direction = avaliable_direction.rotate(opt)[index]
      end
    end

    def next_position
      next_coordinates = @position.coordinates.map.with_index do |coordinate, index|
        coordinate + MOVE_RULES[@direction][index]
      end
      next_position = Position.new(*next_coordinates)
      valid_position?(next_position) ? next_position : nil
    end

    def position=(position)
      if valid_position?(position)
        @position = position
      else
        fail ArgumentError, "#{position.coordinates} coordinates are out of board"
      end
    end

    def direction=(direction)
      if valid_direction?(direction)
        @direction = direction
      else
        fail ArgumentError, "Direction should be in #{avaliable_direction}"
      end
    end

    def valid_position?(position)
      @board.valid_position? position
    end

    def valid_direction?(direction)
      return false unless direction
      avaliable_direction.include? direction
    end

    def avaliable_direction
      MOVE_RULES.keys
    end
  end
end
