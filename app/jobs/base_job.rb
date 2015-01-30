class BaseJob < ActiveJob::Base
  queue_as :default

  def serialize
    super.merge('locale' => I18n.locale, 'label' => Whitelabel[:label_id])
  end

  def deserialize(job_data)
    I18n.locale = job_data['locale']
    Whitelabel.label_for(job_data['label'])
    super
  end
end
