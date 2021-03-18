class DatePickerInput < StringInput
  def input_html_options
    super.merge(data: { datePicker: '' })
  end
end
