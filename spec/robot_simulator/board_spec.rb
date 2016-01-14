require 'spec_helper.rb'

module RobotSimulator
  describe Board do
    it 'should create with valid params' do
      board = Board.new(5, 5)
      expect(board.width).to eq 5
      expect(board.height).to eq 5
    end

    it 'should thorw exception while create with invalid params' do
      expect { Board.new(-1, 20) }.to raise_error ArgumentError
    end
  end
end
