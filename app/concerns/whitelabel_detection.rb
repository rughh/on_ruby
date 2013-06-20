module WhitelabelDetection
  protected

  def switch_label
    Whitelabel.reset!
    unless Usergroup.switch_by_request(request)
      redirect_to labels_url(subdomain: 'www')
    end
  end
end
