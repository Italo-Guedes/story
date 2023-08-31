# frozen_string_literal: true

# Custom input with date picker
class DatePickerInput < StringInput
  def input_html_options
    super.merge(data: { datePicker: '' })
  end
end
