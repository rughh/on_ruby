# frozen_string_literal: true

module TitleHelper
  def page_title
    "#{title} - #{title_mapping ? title_mapping.call : subtitle}"
  end

  def meta_desc
    "#{page_title} - #{I18n.tw('meta_desc')}"
  end

  def title
    I18n.tw('title')
  end

  def subtitle
    I18n.tw('subtitle')
  end

  private

  def title_mapping(controller_name = self.controller_name, action_name = self.action_name)
    {
      'users/show' => -> { user.name },
      'topics/show' => -> { topic.name },
      'locations/show' => -> { location.name },
      'locations/none' => -> { I18n.t('show.no_location') },
      'events/show' => -> { event.name },
    }["#{controller_name}/#{action_name}"]
  end
end
