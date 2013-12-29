class Usergroup
  DELIMITER_TIME    = ':'
  DELIMITER_DATE    = ' '
  NUMBERS           = %w(first second third fourth)
  SUPPORTED_LOCALES = [:de, :en]

  attr_accessor :label_id, :default_locale, :domains, :recurring, :email, :google_group
  attr_accessor :twitter, :organizers, :location, :imprint, :other_usergroups

  def host
    "#{label_id}.#{HOST}"
  end

  def self.from_name(name)
    new.tap do |it|
      it.label_id = it.google_group = it.twitter = name.underscore
      it.default_locale   = 'de'
      it.domains          = ["#{name.parameterize}.de"]
      it.recurring        = 'second wednesday'
      it.email            = "info@#{name.parameterize}.de"
      it.organizers       = ['your_twitter_handle']
      it.location         = {zoom: 14, lat: 53.079296, long: 8.801694}
      it.imprint          = {address: "YourStreet 1\n0815 YourTown", contributors: [{name: "Your Name", email: "your@mail.de"}]}
      it.other_usergroups = [{name: "OtherUsergroupName", url: "http://some-domain.de/", twitter: "some_handle"}]
    end
  end

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

  def to_s
    label_id
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
end
