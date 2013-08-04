class Usergroup
  DELIMITER_TIME = ':'
  DELIMITER_DATE = ' '
  NUMBERS        = %w(first second third)

  attr_accessor :label_id, :default_locale, :domains, :recurring, :email, :mailing_list, :mailing_list_feed_url
  attr_accessor :host, :twitter, :usergroup_email, :organizers, :location, :imprint, :other_usergroups
  attr_accessor :theme

  def parse_recurring_date(date)
    number, day, _ = recurring.split(DELIMITER_DATE)
    day = Date::DAYS_INTO_WEEK[day.to_sym] + 1
    num = NUMBERS.index(number)
    d = date.at_beginning_of_month
    if d.wday > day
      d + ((num + 1) * 7 + day - d.wday).days
    else
      d + (num * 7 + day - d.wday)
    end
  end

  def parse_recurring_time
    _, _, time_string = recurring.split(DELIMITER_DATE)
    if time_string.present?
      hour, min = time_string.split(DELIMITER_TIME)
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

  def localized_recurring
    number, day, _ = recurring.split(DELIMITER_DATE)
    number  = NUMBERS.index(number) + 1
    day     = I18n.t('date.day_names')[Date::DAYS_INTO_WEEK[day.to_sym] + 1]
    I18n.t("event.recurring", number: number, day: day)
  end

  def self.omniauth_keys(provider, request)
    tokens = ["omniauth", provider] + request.domain.gsub(/-/, '').split(".")
    name   = tokens.join("_").upcase
    [ENV["#{name}_KEY"], ENV["#{name}_SECRET"]]
  end

  def self.switch_by_request(request)
    return true if Whitelabel.label_for(request.subdomains.first)
    Whitelabel.label = Whitelabel.labels.find do |label|
      label.domains && label.domains.any? do |custom_domain|
        request.host =~ /#{custom_domain}/
      end
    end
  end

  def to_s
    label_id
  end
end
