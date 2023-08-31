# frozen_string_literal: true

# Custom input with date time picker
class DateTimePickerInput < StringInput
  def input_html_options
    super.merge(data: { dateTimePicker: '' })
  end
end
