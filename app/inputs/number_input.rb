class NumberInput < StringInput
  def to_html
    input_wrapping do
      builder.number_field(method, input_html_options) << label_html
    end
  end

  def step_option
    super || 'any'
  end
end
