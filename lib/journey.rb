class Journey

  attr_reader :entry_station, :exit_station, :log

  def initialize(entry_station)
    @log = {}
    @entry_station = entry_station
    touch_in
  end

  def touch_in
    @log[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @log[:exit_station] = exit_station
  end

end
