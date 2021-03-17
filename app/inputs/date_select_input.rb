class DateSelectInput < StringInput
  def input_html_options
    super.merge(inputmask: 'br-date')
  end
end
