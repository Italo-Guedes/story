class FileInput < Formtastic::Inputs::FileInput
  def to_html
    input_wrapping do
      controls_wrapping do
        removal_html <<
        selection_html
      end <<
      file_label_html
    end
  end

  def removal_html
    template.content_tag(
      :span,
      (
        I18n.t('fileinput.remove').to_s <<
        builder.hidden_field("#{method}_remove", value: '0')
      ).html_safe,
      removal_html_options
    )
  end

  def removal_html_options
    classes = %w[btn btn-danger fileinput-exists]
    { class: classes.compact.join(' '), 'data-dismiss' => 'fileinput' }
  end

  def selection_html
    template.content_tag(
      :span,
      (
        "<span class=\"fileinput-new\">#{I18n.t('fileinput.add')}</span>" <<
        "<span class=\"fileinput-exists\">#{I18n.t('fileinput.change')}</span>" <<
        input_htmls
      ).html_safe,
      class: 'btn btn-primary btn-file'
    )
  end

  def input_htmls
    if preserve
      builder.hidden_field(method, value: preserve) <<
      builder.hidden_field(method, value: nil, name: nil) <<
      builder.file_field(method, input_html_options.merge(name: nil))
    else
      builder.hidden_field(method, value: preserve) <<
      builder.hidden_field(method, value: nil) <<
      builder.file_field(method, input_html_options)
    end
  end
  
  def input_html_options
    new_hash = {}
    if options[:direct_upload] == true
      new_hash['data-direct-upload-url'] = Rails.application.routes.url_helpers.rails_direct_uploads_path
    end
    super.merge(new_hash)
  end

  def attachment
    @attachment ||= object.send(method) rescue nil
  end

  def filename
    attachment.filename if attachment && attachment.attached?
  end

  def file_label_html
    template.content_tag(
      :div,
      template.content_tag(
        :span,
        filename,
        class: 'fileinput-filename'
      ),
      class: "form-control #{'is-invalid' if errors.any?}", 'data-trigger' => 'fileinput'
    )
  end

  def preserve
    @preserve ||= attachment&.signed_id if attachment && attachment&.attached?
  end

  def hint_html
    return nil if hint_text.blank?

    template.content_tag(
      :small,
      hint_text,
      class: 'form-text text-muted'
    )
  end

  def error_html
    return nil if errors.blank?

    template.content_tag(
      :div,
      errors.join('<br/>').html_safe,
      class: 'invalid-feedback'
    )
  end

  def controls_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block),
      class: 'input-group-prepend'
    )
  end

  def input_wrapping(&block)
    template.content_tag(
      :div,
      (
        template.content_tag(
          :div,
          template.capture(&block),
          wrapper_html_options
        ) <<
        error_html <<
        hint_html
      ).html_safe,
      class: [options[:class], 'input-group'].compact.join(' ')
    )
  end

  def wrapper_html_options
    new_class = [super[:class], 'fileinput', 'input-group']
    new_class += preserve ? ['fileinput-exists'] : ['fileinput-new']
    super.merge(class: new_class.compact.join(' '), 'data-provides' => 'fileinput')
  end
end
