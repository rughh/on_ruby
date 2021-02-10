# frozen_string_literal: true

module PreviewHelper
  def material_preview(material)
    return '' if material.preview_type.nil? || (material.preview_type == 'none')

    if material.preview_type == 'video'
      tag.div(class: 'preview video') do
        material.preview_code.html_safe
      end
    elsif material.preview_type == 'image'
      tag.div(class: 'preview image') do
        link_to material.url, title: material.name do
          image_tag(material.preview_code, alt: material.name)
        end
      end
    end
  end
end
