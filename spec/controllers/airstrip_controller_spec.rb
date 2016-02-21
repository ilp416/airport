require 'rails_helper'

RSpec.describe AirstripController, type: :controller do

  describe "GET #index" do

    it "by default show last 10 events" do
      20.times.each do
        Plane.new.start!
      end
      get :index
      expect(assigns[:last_events].count).to eq 10
    end

    it "show records with id more than params[:later_than]" do
      5.times.each do
        Plane.new.start!
      end
      rec_id = PlaneLog.last.id
      Plane.new.start!
      get :index, later_than: rec_id
      expect(rec_id).to be < assigns[:last_events].map(&:id).min
      real_count = PlaneLog.where('id > ?', rec_id).count
      expect(assigns[:last_events].count).to eq real_count
    end

  end

  describe "PUT #launch_planes" do
    it "returns http success" do
      expect {
        put :launch_planes, planes_count: 5
      }.to change(Plane, :count).by(5)
    end
    
  end

end
