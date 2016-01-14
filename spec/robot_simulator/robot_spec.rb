require 'spec_helper.rb'

module RobotSimulator
  describe Robot do
    let(:board) { Board.new }
    let(:robot) { Robot.new board }

    it 'should create with valid params' do
      expect(robot.board).not_to be_nil
    end

    context 'placing' do
      it 'should place robot into default position' do
        robot.place
        expect(robot.report).to eq '0,0,NORTH'
      end

      it 'should place robot into specified position' do
        robot.place(3, 4, :east)
        expect(robot.report).to eq '3,4,EAST'
      end

      it 'should throw exception when place robot into wrong coordinates' do
        expect { robot.place(3, 6) }.to raise_error ArgumentError
      end

      it 'should throw exception when place robot into wrong direction' do
        expect { robot.place(3, 5, :south_west) }.to raise_error ArgumentError
      end
    end

    context 'rotating' do
      it 'should change direction' do
        robot.place
        robot.right
        expect(robot.report).to eq '0,0,EAST'
        robot.left
        expect(robot.report).to eq '0,0,NORTH'
      end

      it "shouldn't rotate if not placed" do
        expect { robot.right }.to raise_error PlacingError
      end
    end

    context 'moving' do
      it 'should move one cell forward' do
        robot.place
        robot.right
        robot.move
        expect(robot.report).to eq '1,0,EAST'
      end

      it "shouldn't move out of borders" do
        robot.place
        robot.left
        robot.move
        expect(robot.report).to eq '0,0,WEST'
      end

      it "shouldn't move if not placed" do
        expect { robot.move }.to raise_error PlacingError
      end
    end
  end
end
