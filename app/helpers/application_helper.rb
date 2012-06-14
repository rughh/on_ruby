module ApplicationHelper
  def title
    I18n.tw("title")
  end

  def subtitle
    I18n.tw("subtitle")
  end

  def page_title
    t = []
    t << I18n.tw("name") if Whitelabel.label
    t << title
    t << (content_for?(:page_title) ? content_for(:page_title) : subtitle)
    t << meta_desc
    t.join(' - ')
  end

  def meta_desc
    I18n.tw("meta_desc")
  end

  def map(locations, init={})
    locations = Array(locations)
    init = Whitelabel[:location].merge(init)
    content_tag(:div, '', class: 'map_canvas', 'data-map' => locations.to_json, 'data-init' => init.to_json)
  end

  def section_box(name)
    content_tag :section, class: name, id: name do
      concat content_tag(:h2, t(name))
      yield
    end
  end

  def hint(close=true)
    content_tag(:section, class: :hint) do
      concat content_tag(:div, link_to(t("hint.close"), '#'), class: :close) if close
      yield
    end
  end
end
