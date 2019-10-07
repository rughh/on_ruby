# frozen_string_literal: true

class Usergroup
  DELIMITER_TIME    = ':'
  DELIMITER_DATE    = ' '
  NUMBERS           = %w[first second third fourth].freeze
  DAYS_INTO_WEEK    = {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }.freeze

  attr_accessor :label_id, :default_locale, :domains, :recurring, :custom_recurring, :email, :google_group, :coc
  attr_accessor :default_time_zone, :twitter, :organizers, :location, :imprint, :other_usergroups, :tld # TODO: get rid of tld
  attr_accessor :sponsors, :slackin_url, :country, :status, :github_org, :github_repo, :github_issue_template
  attr_accessor :canonical_url

  def parse_recurring_date(date)
    number, day, = recurring.split(DELIMITER_DATE)
    day = DAYS_INTO_WEEK[day.to_sym] + 1
    if number == 'last'
      d = date.at_end_of_month.change(hour: 0, minute: 0, second: 0)
      d - ((d.wday - day) % 7).days
    else
      d = date.at_beginning_of_month
      num = NUMBERS.index(number)

      if d.wday > day
        d + ((num + 1) * 7 + day - d.wday).days
      else
        d + (num * 7 + day - d.wday).days
      end
    end
  end

  def parse_recurring_time
    _, _, time_string = recurring.split(DELIMITER_DATE)
    if time_string.present?
      hour, min = time_string.split(DELIMITER_TIME)
      Time.new(2012, 5, 1, hour.to_i, min.to_i)
    else
      Time.new(2012, 5, 1, 19, 0)
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

    number, day, = recurring.split(DELIMITER_DATE)

    ordinal = I18n.t("event.#{number}")
    day     = I18n.t('date.day_names')[DAYS_INTO_WEEK[day.to_sym] + 1]

    I18n.t('event.recurring', ordinal: ordinal, day: day)
  end

  def localized_custom_recurrence
    recurrence_text = I18n.tw('custom_recurrence')
    # fall back to default locale
    recurrence_text = I18n.tw('custom_recurrence', locale: default_locale) if recurrence_text == 'n/a'
    recurrence_text == 'n/a' ? nil : recurrence_text
  end

  def enabled?
    status == 'enabled'
  end

  def to_s
    label_id
  end

  def self.from_name(name)
    raise 'you need to provide a name that contains only word characters' unless name =~ /\A\w+\z/

    new.tap do |it|
      it.label_id = it.google_group = it.twitter = name.underscore
      it.default_locale   = 'de'
      it.tld              = 'de'
      it.country          = 'Deutschland'
      it.domains          = ["#{name.parameterize}.de"]
      it.recurring        = 'second wednesday'
      it.email            = "info@#{name.parameterize}.de"
      it.twitter          = name.parameterize
      it.github_org       = name.parameterize
      it.github_repo      = 'planning'
      it.organizers       = ['your_twitter_handle']
      it.location         = { zoom: 14, lat: 53.079296, long: 8.801694 }
      it.imprint          = { address: "YourStreet 1\n0815 YourTown", contributors: [{ name: 'Your Name', email: 'your@mail.de' }] }
      it.other_usergroups = [{ name: 'OtherUsergroupName', url: 'http://some-domain.de/', twitter: 'some_handle' }]
      it.coc              = 'http://example.com'
      it.sponsors         = []
    end
  end

  def self.initialize!
    Whitelabel.from_file Rails.root.join('config/whitelabel.yml')
  end
end
