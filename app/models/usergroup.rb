class Usergroup
  attr_accessor :label_id, :domains, :recurring, :email, :mailing_list, :host, :twitter, :usergroup_email, :organizers, :location, :imprint, :other_usergroups

  def parse_recurring_date(date)
    num, day = recurring.split
    day = Date::DAYS_INTO_WEEK[day.to_sym] + 1
    num = %w(first second third).index(num)
    d = date.at_beginning_of_month
    if d.wday > day
      d + ((num + 1) * 7 + day - d.wday).days
    else
      d + (num * 7 + day - d.wday)
    end
  end

  def parse_recurring_time
    num, day, time_string = recurring.split
    if time_string.present?
      hour, min = time_string.split(':')
      t = Time.new(2012, 5, 1, hour.to_i, min.to_i)
    else
      t = Time.new(2012, 5, 1, 19, 0)
    end
  end

  def next_event_date
    d = parse_recurring_date(Date.today)
    d = parse_recurring_date(Date.today.next_month) unless d.future?
    t = parse_recurring_time
    Time.new(d.year, d.month, d.day, t.hour, t.min)
  end
end
