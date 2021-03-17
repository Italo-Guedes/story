class PasswordInput < StringInput
  def to_html
    input_wrapping do
      builder.password_field(method, input_html_options) << label_html
    end
  end
end
