class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @log = {}
    @entry_station = entry_station
    log_entry
  end

  def log_entry
    @log[:entry] = @entry_station
  end

  def log_exit(exit_station)
    @log[:exit] = exit_station
    @exit_station = exit_station
  end

  def log
    @log
  end

end
