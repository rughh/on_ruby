module ApplicationHelper

  Menu = Struct.new :name, :controller, :action
  MENU_ENTRIES = [
    Menu.new(:info,     :home,    :info),
    Menu.new(:events,   :events,  :index),
    Menu.new(:users,    :users,   :index),
    Menu.new(:wishes,   :wishes,  :index),
    Menu.new(:imprint,  :home,    :imprint),
  ]

  def menu
    MENU_ENTRIES.map do |item|
      content_tag :li, :class => css_class_for_menu_item(item) do
        content_tag(:span) + content_tag(:b) do
          link_to t("menu.#{item.name}"), :controller => item.controller, :action => item.action
        end
      end
    end.join.html_safe
  end

  def login
    content_tag(:div, :class => 'login') do
      content_tag :li do
        content_tag(:span) + content_tag(:b) do
          if current_user
            link_to t("menu.logout", :name => current_user.nickname), destroy_session_path
          else
            link_to t("menu.login"), auth_path
          end
        end
      end
    end.html_safe
  end

  def flash_growl
    if notice
      js add_gritter(flash[:notice], :image => :notice, :title => "Hey:", :time => 2000)
    elsif alert
      js add_gritter(flash[:alert], :image => :warning, :title => "Ohoh:", :time => 3000)
    end
  end

  private

    def css_class_for_menu_item(item)
      item.controller == controller.controller_name.to_sym && item.action == controller.action_name.to_sym ? 'active' : ''
    end

end
