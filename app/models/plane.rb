class Plane < ActiveRecord::Base

  has_many :plane_logs

  include AASM

  aasm column: :state do
    state :new, initial: true
    state :running
    state :flew

    after_all_transitions :log_plane_state

    event :start, before: :save_if_new, after: :perform_launching do
      transitions from: :new, to: :running
    end

    event :launched do
      transitions from: :running, to: :flew
    end

  end

  def log_plane_state
    plane_logs.create(state: aasm.to_state)
  end

  def perform_launching
    return false unless may_launched?
    Thread.new do
      sleep 5.seconds
      launched!
    end
  end

  def save_if_new
    save if new_record?
  end

end
