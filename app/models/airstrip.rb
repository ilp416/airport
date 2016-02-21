class Airstrip

  def self.free?
    Plane.where(state: 'running').empty?
  end
  def self.busy?
    !free?
  end

end
