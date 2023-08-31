# frozen_string_literal: true

# Custom input with datetime inputmask
class DatetimeSelectInput < StringInput
  def input_html_options
    super.merge(inputmask: 'br-datetime')
  end
end
