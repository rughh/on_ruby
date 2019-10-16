module HomeHelper
  def next_event_date
    l(Whitelabel[:next_event_date], format: :long)
  end

  def localized_recurring_event_date
    Whitelabel[:localized_recurring]
  end
end
