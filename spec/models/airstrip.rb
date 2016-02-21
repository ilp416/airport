require 'rails_helper'

RSpec.describe Airstrip, type: :model do

  it 'run delayed planes after airstrip was free' do
    allow(Plane).to receive(:perform_launching).and_return(@plane.launched!)
    Plane.new.start!
    Plane.new.start!
    expect(Plane.flew.count).to be 2
  end

end
