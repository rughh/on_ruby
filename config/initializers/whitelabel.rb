Usergroup = Struct.new :label_id, :domains, :email, :mailing_list, :host, :twitter, :usergroup_email, :organizers, :location, :imprint, :other_usergroups

# TODO (ps) this inheritance cold be greatly reduced with some configuration option:
# ie: recurring: every_third_wednesday
class Rughh < Usergroup
  def next_event_date
    d = second_wednesday(Date.today)
    d = second_wednesday(Date.today.next_month) if d < Date.today
    Time.new(d.year, d.month, d.day, 19, 0)
  end

  def second_wednesday(date)
    d = date.at_beginning_of_month
    d.wday > 3 ? d + (17 - d.wday).days : d + (10 - d.wday)
  end
end

class Hackhb < Usergroup
  def next_event_date
    d = first_wednesday(Date.today)
    d = first_wednesday(Date.today.next_month) if d < Date.today
    Time.new(d.year, d.month, d.day, 19, 0)
  end

  def first_wednesday(date)
    d = date.at_beginning_of_month
    d.wday > 3 ? d + (10 - d.wday).days : d + (3 - d.wday)
  end
end

class Colognerb < Usergroup
  def next_event_date
    d = third_wednesday(Date.today)
    d = third_wednesday(Date.today.next_month) if d < Date.today
    Time.new(d.year, d.month, d.day, 19, 0)
  end

  def third_wednesday(date)
    d = date.at_beginning_of_month
    d.wday > 3 ? d + (24 - d.wday).days : d + (17 - d.wday)
  end
end

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
