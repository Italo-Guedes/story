# frozen_string_literal: true

# Input with email tag
class EmailInput < StringInput
  def to_html
    input_wrapping do
      builder.email_field(method, input_html_options) << label_html
    end
  end
end
