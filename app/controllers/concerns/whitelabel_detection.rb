# typed: false
module WhitelabelDetection
  protected

  def switch_label
    Whitelabel.reset!

    return if Whitelabel.label_for(request.subdomains.first)

    Whitelabel.label = Whitelabel.labels.find do |label|
      label.domains && label.domains.any? do |custom_domain|
        request.host =~ /#{custom_domain}/
      end
    end
    Whitelabel.label ||= Whitelabel.labels.first
  end
end
