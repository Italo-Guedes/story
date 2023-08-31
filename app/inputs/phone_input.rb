# frozen_string_literal: true

# Input with phone input tag
class PhoneInput < StringInput
  def to_html
    input_wrapping do
      builder.phone_field(method, input_html_options) << label_html
    end
  end
end
