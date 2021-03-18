class DateTimePickerInput < StringInput
  def input_html_options
    super.merge(data: { dateTimePicker: '' })
  end
end
