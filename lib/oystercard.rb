require_relative 'station'

class Oystercard

  attr_reader :balance, :all_journeys, :journey

  DEFAULT_MAX = 90
  MIN_FARE = 1
  PEN_FARE = 6

  def initialize
    @balance = 0
    @all_journeys = []
  end

  def top_up(cash)
    over_max_balance?(cash)
    add_money(cash)
  end

  def touch_in(entry_station)
    raise "INSUFFICIENT FUNDS" if insufficient_funds?
    @journey = Journey.new(entry_station)
  end

  def in_journey?
    (@journey.log.include?(:entry)) && !(@journey.log.include?(:exit))
  end

  def touch_out(exit_station)
    if !@journey.nil?
      @journey.touch_out(exit_station)
      store_journey(exit_station)
    end
    deduct_fare
  end

  def fare
    if (@journey.nil?) || ((@journey.log.include?(:entry)) && (!@journey.log.include?(:exit)))
      PEN_FARE
    else
      MIN_FARE
    end
  end

  private

  def store_journey(exit_station)
    @all_journeys << @journey.log
  end

  def insufficient_funds?
    @balance < MIN_FARE
  end

  def deduct_fare
    @balance -= fare
  end

  def add_money(cash)
    @balance += cash
  end

  def over_max_balance?(cash)
    if (cash + balance) > DEFAULT_MAX
      raise "Max balance of #{DEFAULT_MAX} is exceeded"
    end
  end

end
