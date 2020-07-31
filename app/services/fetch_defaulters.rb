class FetchDefaulters < Service::Base
  def initialize
    
  end

  def perform
    defaulters = {}
    count = 0
    while count <= 7
      day = (count + 1).days.ago
      defaulters[day.strftime('%A')] = filter_no_payment(day: day) if day.wday <= 5 && day.wday > 0
      count += 1
    end

    Service::Result.new.tap do |result|
      result.succeed(defaulters)
    end
  end

  private def filter_no_payment(day:)
    Driver.where.not(id: days_payment(day: day))
      .where('users.created_at < ? ', day.beginning_of_day)
  end

  private def days_payment(day:)
    Payment.where('payments.created_at between ? and ?', day.beginning_of_day, day.end_of_day).map(&:driver_id)
  end
end