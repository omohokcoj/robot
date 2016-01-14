require 'spec_helper.rb'

module RobotSimulator
  describe Application do
    let(:application) { Application.new }
    it 'should create' do
      expect(application).not_to be_nil
    end

    it 'should execure script' do
      answer = application.perform_script('scripts/3')
      expect(answer).to eq '3,3,NORTH'
    end
  end
end
