module RobotSimulator
  class Board
    AVALIABLE_WIDTH  = (2..80)
    AVALIABLE_HEIGHT = (2..80)

    attr_reader :width, :height

    def initialize(width = 5, height = 5)
      @width  = width
      @height = height
      validate_size
    end

    def valid_position?(position)
      return false unless position
      [%w(width x), %w(height y)].map do |property, coordinate|
        range = 0..instance_variable_get("@#{property}")
        range.include?(position.send coordinate)
      end.all?
    end

    private

    def validate_size
      %w(width height).each do |property|
        range = self.class.const_get "AVALIABLE_#{property.upcase}"
        unless range.include? instance_variable_get("@#{property}")
          fail ArgumentError, "Board #{property} should be in #{range}"
        end
      end
    end
  end
end
