class Plane < ActiveRecord::Base

  has_many :plane_logs

  include AASM

  aasm column: :state do
    state :new, initial: true
    state :delayed
    state :running
    state :flew

    after_all_transitions :log_plane_state

    event :start, before: :save_if_new, after: :perform_launching do
      transitions from: [:new, :delayed], to: :delayed, unless: :can_start?
      transitions from: [:new, :delayed], to: :running, guard: :can_start?
    end

    event :launched, after: :start_delayed_planes do
      transitions from: :running, to: :flew
    end

  end

  def can_start?
    Airstrip.free?
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

  def start_delayed_planes
    Airstrip.start_delayed_planes
  end


end
