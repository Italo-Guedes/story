# frozen_string_literal: true

# Checkbox input with template styling
class ButtonAction < Formtastic::Actions::ButtonAction
  def to_html
    wrapper do
      template.button_tag(text, button_html)
    end
  end

  def wrapper(&block)
    template.content_tag(
      :div,
      template.capture(&block),
      class: options[:class].to_s
    )
  end

  def extra_button_html_options
    new_class = [super[:class], 'btn', 'btn-primary', 'btn-sm'].compact.join(' ')
    super.merge(class: new_class).merge(options[:html]) if options[:html].present?
  end
end
