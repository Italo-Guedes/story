# frozen_string_literal: true

# <div class="form-group">
#   <label>Example select</label>
#   <div class="select">
#     <select class="form-control">
#       <option>Option 1</option>
#       <option>Option 2</option>
#       <option>Option 3</option>
#       <option>Option 4</option>
#       <option>Option 5</option>
#     </select>
#     <i class="form-group__bar"></i>
#   </div>
# </div>
class SelectInput < Formtastic::Inputs::SelectInput
  def to_html
    input_wrapping do
      builder.select(input_name, collection, input_options, input_html_options)
    end
  end

  def hint_html
    return nil if hint_text.blank?

    template.content_tag(
      :small,
      hint_text,
      class: 'form-text text-muted'
    )
  end

  def error_html
    return nil if errors.blank?

    template.content_tag(
      :div,
      errors.join('<br/>').html_safe,
      class: 'invalid-feedback'
    )
  end

  def input_html_options
    new_class = [super[:class], 'form-control', errors.any? ? 'is-invalid' : nil].compact.join(' ')
    super.merge(class: new_class)
  end

  def line_html
    '<i class="form-group__bar"></i>'
  end

  def input_wrapping(&block)
    template.content_tag(
      :div,
      (
        label_html <<
        template.content_tag(
          :div,
          [template.capture(&block), line_html].join("\n").html_safe,
          class: 'select'
        ) <<
        error_html <<
        hint_html
      ).html_safe,
      wrapper_html_options
    )
  end

  def wrapper_html_options
    new_class = ([options[:class], super[:class], 'form-group']).compact.join(' ').gsub(' select', '')
    super.merge(class: new_class)
  end
end