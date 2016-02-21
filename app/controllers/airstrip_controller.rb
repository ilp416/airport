class AirstripController < ApplicationController

  def index
    @last_events = 
      if params[:later_than]
        PlaneLog.order('id DESC').where('id > ?', params[:later_than])
      else
        PlaneLog.order('id DESC').limit(10)
      end
    respond_to do |format|
      format.html
      format.js { render 'events' }
    end
  end

  def launch_planes
    params[:planes_count].to_i.times.each do 
      Plane.new.start!
    end
    respond_to do |format|
      format.html { redirect_to airstrip_path }
      format.js { render nothing: true }
    end
  end
end
