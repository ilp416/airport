class Airstrip

  def self.free?
    Plane.running.empty?
  end

  def self.busy?
    !free?
  end

  def self.start_delayed_planes
    return if Airstrip.busy?
    Plane.delayed.first.try(:start!)
  end

end
