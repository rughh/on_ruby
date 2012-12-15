module MobileHelper
  def link_to_login
    content_tag :div, data: {role: :controlgroup, type: :horizontal} do
      [:twitter, :github].each do |provider|
        title = t("login.#{provider}_login")
        concat link_to(title, auth_path(provider: provider), title: title, rel: :external, data: {role: :button})
      end
    end
  end
end
