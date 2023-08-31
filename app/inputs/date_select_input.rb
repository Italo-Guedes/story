# frozen_string_literal: true

# Custom input with inputmask date mask
class DateSelectInput < StringInput
  def input_html_options
    super.merge(inputmask: 'br-date')
  end
end
