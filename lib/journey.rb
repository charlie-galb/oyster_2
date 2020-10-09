class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @log = {}
    @entry_station = entry_station
    touch_in
  end

  def touch_in
    @log[:entry] = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @log[:exit] = exit_station
  end

  def log
    @log
  end

end
