# frozen_string_literal: true

# Checkbox input with template styling
class BooleanInput < Formtastic::Inputs::BooleanInput
  # Original checkbox HTML
  # <li class="boolean" id="post_published_input">
  #   <input type="hidden" name="post[published]" id="post_published" value="0">
  #   <label for="post_published">
  #     <input type="checkbox" name="post[published]" id="post_published" value="1">
  #     Published?
  #   </label>
  # </li>

  # Current html
  # <div class="checkbox">
  #   <input type="hidden" name="teste" value="0">
  #   <input type="checkbox" name="teste" id="customCheck1">
  #   <label class="checkbox__label" for="customCheck1">Check this custom checkbox</label>
  # </div>
  def error_html
    return nil if errors.blank?

    template.content_tag(
      :div,
      errors.join('<br/>').html_safe,
      class: 'invalid-feedback'
    )
  end

  def to_html
    input_wrapping do
      hidden_field_html <<
        label_with_nested_checkbox <<
        error_html
    end
  end

  def label_html_options
    {
      for: input_html_options[:id],
      class: super[:class] - ['label'] + ['checkbox__label']
    }
  end

  def label_with_nested_checkbox
    check_box_html <<
      builder.label(
        method,
        label_text,
        label_html_options
      )
  end

  def input_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block),
      wrapper_html_options
    )
  end

  def wrapper_html_options
    new_class = [
      options[:class],
      super[:class],
      'form-group checkbox',
      errors.any? ? 'is-invalid' : nil
    ].compact.join(' ')
    super.merge(class: new_class)
  end
end
