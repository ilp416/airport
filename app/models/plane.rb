class Plane < ActiveRecord::Base

  include AASM

  aasm column: :state do
    state :new, :initial => true
    state :running
    state :flew

    event :start, after: :perform_launching do
      transitions :from => :new, :to => :running
    end

    event :launched do
      transitions :from => :running, :to => :flew
    end

  end

  def perform_launching
    Thread.new do
      sleep 5.seconds
      launched!
    end
  end


end
