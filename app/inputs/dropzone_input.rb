class DropzoneInput
  include Formtastic::Inputs::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper

  def to_html
    preserve_attachments = preserve
    template.content_tag(
      :div,
      (
        if preserve_attachments
          htmls = []
          preserve_attachments.each do |attachment|
            htmls << input_htmls(attachment)
          end
          builder.file_field(method, input_html_options) << 
          htmls.join().html_safe
        else
          builder.file_field(method, input_html_options) << file_label_html
        end
      ),
      dropzone_classes(input_html_options["dropzone_html"])
    )
  end

  def input_htmls(attachment)
    signed_id = attachment.signed_id
    active_storage_input = "active_storage_input_#{attachment.id}"
    active_storage_div = "active_storage_div_#{attachment.id}"
    "<input value=\"#{signed_id}\" id=\"#{active_storage_input}\" type=\"hidden\" name=\"#{object.class.name.underscore}[#{method}][]\" />" <<
    template.content_tag(
      :div,
      (
        ("<div class=\"dz-image\">#{img_html(attachment)}</div>" <<
        "<div class=\"dz-details\">#{details(attachment)}</div>" <<
        "<a class=\"dz-remove\" onclick=\"document.getElementById(`#{active_storage_input}`).remove();document.getElementById(`#{active_storage_div}`).remove()\" data-dz-remove></a>")
      ).html_safe,
      class: 'dz-preview dz-image-preview dz-processing dz-success dz-complete',
      id: "#{active_storage_div}"
    )
  end

  def img_html(attachment)
    "<img data-dz-thumbnail alt=\"#{attachment.filename}\" src=\"#{url_for(ApplicationController.helpers.thumb(attachment))}\" style=\"width: 100%;\" />".html_safe if attachment #&& attachment.attached?
  end

  def details(attachment)
    ("<div class=\"dz-size\">#{size(attachment)}</div>" <<
    "<div class=\"dz-filename\">#{filename(attachment)}</div>").html_safe
  end

  def size(attachment)
    template.content_tag(
      :span,
      number_to_human_size(attachment.byte_size)&.gsub(',', '.')
    )
  end

  def filename(attachment)
    template.content_tag(
      :span,
      attachment.filename
    )
  end
  
  def preserve
    @preserve ||= attachment if attachment
  end

  def attachment
    @attachment ||= object.send(method) rescue nil
  end

  def dropzone_classes(options)
    max_size_mb = options && options[:max_size_mb].present? ? options[:max_size_mb] : 20
    max_files = options && options[:max_files].present? ? options[:max_files] : 20
    accepted_files = options && options[:accepted_files].present? ? options[:accepted_files] : 'audio/ogg,image/jpeg,image/gif,image/png'
    classes = %w[dropzone dropzone-default dz-clickable]
    { class: classes.compact.join(' '), 'data-controller' => 'dropzone', 'data-dropzone-max-file-size' => "#{max_size_mb}", 'data-dropzone-max-files'=> "#{max_files}", 'data-dropzone-accepted-files' => "#{accepted_files}",  'style' => 'margin: 30px 0px;' }
  end

  def input_html_options
    new_hash = {}
    new_hash['multiple'] = 'multiple'
    new_hash['data-target'] = 'dropzone.input'
    if options[:direct_upload] == true
      new_hash['data-direct-upload-url'] = Rails.application.routes.url_helpers.rails_direct_uploads_path
    end
    if options[:dropzone_html].present?
      new_hash['dropzone_html'] = { max_size_mb: options[:dropzone_html][:max_size_mb],
                                    max_files: options[:dropzone_html][:max_files],
                                    accepted_files: options[:dropzone_html][:accepted_files] }
    end
    super.merge(new_hash)
  end

  def file_label_html
    template.content_tag(
      :div,
      (
        ("<h4 class=\"dropzone-msg-title\">#{I18n.t('fileinput.multiple_add')}</h4>" <<
        "<span class=\"dropzone-msg-desc text-sm\">#{I18n.t('fileinput.multiple_warning')}</span>")
      ).html_safe,
      class: 'dropzone-msg dz-message needsclick'
    )
  end
end