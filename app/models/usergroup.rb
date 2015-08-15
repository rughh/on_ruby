class Usergroup
  DELIMITER_TIME    = ':'
  DELIMITER_DATE    = ' '
  NUMBERS           = %w(first second third fourth)

  attr_accessor :label_id, :default_locale, :domains, :recurring, :custom_recurring, :email, :google_group, :coc, :default_time_zone
  attr_accessor :twitter, :organizers, :location, :imprint, :other_usergroups, :tld, :sponsors

  def parse_recurring_date(date)
    number, day, _ = recurring.split(DELIMITER_DATE)
    day = Date::DAYS_INTO_WEEK[day.to_sym] + 1
    if number == 'last' then
      d = date.at_end_of_month.change(hour: 0, minute: 0, second: 0)
      d - ((d.wday - day) % 7).days
    else
      d = date.at_beginning_of_month
      num = NUMBERS.index(number)
      if d.wday > day
        d + ((num + 1) * 7 + day - d.wday).days
      else
        d + (num * 7 + day - d.wday)
      end
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
    return localized_custom_recurrence if custom_recurring

    number, day, _ = recurring.split(DELIMITER_DATE)

    ordinal = I18n.t("event.#{number}")
    day     = I18n.t('date.day_names')[Date::DAYS_INTO_WEEK[day.to_sym] + 1]

    I18n.t("event.recurring", ordinal: ordinal, day: day)
  end

  def localized_custom_recurrence
    recurrence_text = I18n.tw('custom_recurrence')
    recurrence_text = I18n.tw('custom_recurrence', locale: default_locale) if recurrence_text == 'n/a' # fall back to default locale
    recurrence_text == 'n/a' ? nil : recurrence_text
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

  def self.from_name(name)
    raise "you need to provide a name that contains only word characters" unless name =~ /\A\w+\z/

    new.tap do |it|
      it.label_id = it.google_group = it.twitter = name.underscore
      it.default_locale   = 'de'
      it.tld              = 'de'
      it.domains          = ["#{name.parameterize}.de"]
      it.recurring        = 'second wednesday'
      it.email            = "info@#{name.parameterize}.de"
      it.organizers       = ['your_twitter_handle']
      it.location         = {zoom: 14, lat: 53.079296, long: 8.801694}
      it.imprint          = {address: "YourStreet 1\n0815 YourTown", contributors: [{name: "Your Name", email: "your@mail.de"}]}
      it.other_usergroups = [{name: "OtherUsergroupName", url: "http://some-domain.de/", twitter: "some_handle"}]
      it.coc              = 'http://example.com'
      it.sponsors         = []
    end
  end

  def self.initialize!
    Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
  end
end
