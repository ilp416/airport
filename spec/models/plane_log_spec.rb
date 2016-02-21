require 'rails_helper'

RSpec.describe PlaneLog, type: :model do
  before do
    @plane = Plane.create
  end

  it 'store states of plane' do
    allow(@plane).to receive(:perform_launching)
    @plane.start!
    expect(@plane.plane_logs.last.try(:state)).to eq "running"
    @plane.launched!
    expect(@plane.plane_logs.last.try(:state)).to eq "flew"
  end

end
