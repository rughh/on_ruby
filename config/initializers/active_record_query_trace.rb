if Rails.env.test?
  ActiveRecordQueryTrace.enabled = true
end
