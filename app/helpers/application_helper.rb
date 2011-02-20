module ApplicationHelper

  def awesome_link_to(name, url, options={})
    content_tag :li, :class => css_class_for_link(name, url) do
      content_tag(:span) + content_tag(:b) { link_to t("menu.#{name}", options), url }
    end
  end
  
  def flash_growl
    if notice
      js add_gritter(flash[:notice], :image => :notice, :title => "Hey:", :time => 2000)
    elsif alert
      js add_gritter(flash[:alert], :image => :warning, :title => "Ohoh:", :time => 3000)
    end
  end

private

  def css_class_for_link(name, url)
    controller.controller_name == name.to_s || url.include?(request.fullpath) ? "active" : ""
  end

end
