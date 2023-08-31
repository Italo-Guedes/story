# frozen_string_literal: true

# Custom input with color input tag
class ColorInput < StringInput
  def to_html
    input_wrapping do
      builder.color_field(method, input_html_options) << label_html
    end
  end
end
