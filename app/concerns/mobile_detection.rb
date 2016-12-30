module MobileDetection
  protected

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root.join('app/views/mobile')
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
end
