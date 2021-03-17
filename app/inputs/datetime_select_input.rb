class DatetimeSelectInput < StringInput
  def input_html_options
    super.merge(inputmask: 'br-datetime')
  end
end
