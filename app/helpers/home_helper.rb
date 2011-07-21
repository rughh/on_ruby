module HomeHelper
  def next_event_date
    d = Date.today.at_beginning_of_month.next_month
    d = d.wday > 3 ? d + (17 - d.wday).days : d + (10 - d.wday)
    Time.utc(d.year, d.month, d.day, 19, 0)
  end
end