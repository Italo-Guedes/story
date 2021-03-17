# frozen_string_literal: true

# <div class="radio">
#   <input type="radio" name="customRadio" id="customRadio1">
#   <label class="radio__label" for="customRadio1">Check this custom radio</label>
# </div>
class RadioInput < Formtastic::Inputs::RadioInput
  def to_html
    input_wrapping do
      legend_html <<
      error_html <<
      choices_group_wrapping do
        collection.map { |choice|
          choice_html(choice)
        }.join("\n").html_safe
      end <<
      hint_html
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

  def legend_html
    if render_label?
      template.content_tag(:div,
        template.content_tag(:label, label_text),
        label_html_options.merge(:class => "label")
      )
    else
      ''.html_safe
    end
  end

  def choices_group_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block)
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
    new_class = [options[:class], super[:class], 'radio__group', errors.any? ? 'is-invalid' : nil].compact.join(' ')
    super.merge(class: new_class)
  end

  def choice_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block)
    )
  end

  # <div class="radio">
  #   <input type="radio" name="customRadio" id="customRadio1">
  #   <label class="radio__label" for="customRadio1">Check this custom radio</label>
  # </div>
  def choice_html(choice)
    template.content_tag(
      :div,
      builder.radio_button(input_name, choice_value(choice), input_html_options.merge(choice_html_options(choice)).merge(:required => false)) << 
      choice_label(choice),
      class: 'radio'
    )
  end

  def choice_label(choice)
    template.content_tag(
      :label,
      super(choice),
      label_html_options.merge(for: choice_input_dom_id(choice))
    )
  end

  def label_html_options
    super.merge(for: nil, class: 'radio__label')
  end
end
