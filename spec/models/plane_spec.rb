require 'rails_helper'

RSpec.describe Plane, type: :model do

  before do
    @plane = Plane.new
  end

  it 'have state new after create' do
    expect(@plane.state).to eq "new"
  end

  it 'have state running on running by airstrip before fly' do
    @plane.start!
    expect(@plane.state).to eq "running"
  end

  it 'have state flew after few seconds after running by airstrip' do
    @plane.start!
    allow(@plane).to receive(:perform_launching).and_return(@plane.launched!)
    expect(@plane.state).to eq "flew"
  end

  it 'cannot to perform launching if not running' do
    expect(@plane.perform_launching).to be false 
  end

  it 'cannot be start if other plane is running' do
    Plane.create state: 'running'
    @plane.start
    expect(@plane.state).to eq 'delayed'
  end

end
