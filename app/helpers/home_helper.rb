module HomeHelper
  def next_event_date
    d = second_wednesday(Date.today)
    d = second_wednesday(Date.today.next_month) if d < Date.today
    Time.utc(d.year, d.month, d.day, 19, 0)
  end
  
  def second_wednesday(date)
    d = date.at_beginning_of_month
    d.wday > 3 ? d + (17 - d.wday).days : d + (10 - d.wday)
  end
end