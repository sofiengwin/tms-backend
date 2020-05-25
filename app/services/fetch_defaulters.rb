class FetchDefaulters < Service::Base
  def initialize
    
  end

  def perform
    defaulters = {}
    count = 1
    while count <= 7
      day = (count + 1).days.ago
      defaulters[day.strftime('%A')] = defaulters(day) if day.wday <= 5 && day.wday > 0
      count += 1
    end

    Service::Result.new.tap do |result|
      result.succeed(defaulters)
    end
  end

  private def defaulters(day)
    Driver.joins(:payments).where.not('users.created_at < payments.created_at AND payments.created_at between ? and ?', day.beginning_of_day, day.end_of_day)
  end
end