# frozen_string_literal: true

# Input with file tag and image preview
class ImageInput < FileInput
  include Rails.application.routes.url_helpers

  def file_preview_html
    template.content_tag(
      :div,
      img_html,
      class: 'fileinput-preview img-thumbnail', 'data-trigger' => 'fileinput'
    )
  end

  def img_html
    return unless attachment&.attached?

    "<img src=\"#{url_for(ApplicationController.helpers.thumb(attachment))}\" alt=\"Image selection thumbnail\" />".html_safe
  end

  def input_wrapping(&block)
    template.content_tag(
      :div,
      (
        label_html <<
        file_preview_html <<
        template.content_tag(
          :div,
          template.capture(&block),
          wrapper_html_options
        ) <<
        error_html <<
        hint_html
      ).html_safe,
      class: [options[:class], 'input-group', 'fileinput'].compact.join(' ')
    )
  end

  def wrapper_html_options
    new_class = [super[:class], 'input-group']
    new_class += preserve ? ['fileinput-exists'] : ['fileinput-new']
    super.merge(class: new_class.compact.join(' '), 'data-provides' => 'fileinput')
  end
end
