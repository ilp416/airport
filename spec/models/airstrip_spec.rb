require 'rails_helper'

RSpec.describe Airstrip, type: :model do

  it 'run delayed planes after airstrip was free' do
    @plane_1 = Plane.create state: 'running'
    @plane_2 = Plane.new
    @plane_2.start!
    expect(@plane_2.state).to eq 'delayed'
    @plane_1.launched!
    expect(@plane_1.state).to eq 'flew'
    expect(@plane_2.plane_logs.last.state).to eq 'running'
  end

end
