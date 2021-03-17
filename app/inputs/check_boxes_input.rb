class CheckBoxesInput < Formtastic::Inputs::CheckBoxesInput
    
  # Original html
  #   <li class='check_boxes'>
  #     <fieldset>
  #       <legend class="label"><label>Categories</label></legend>
  #       <ol>
  #         <li>
  #           <input type="hidden" name="post[category_ids][1]" value="">
  #           <label for="post_category_ids_1"><input id="post_category_ids_1" name="post[category_ids][1]" type="checkbox" value="1" /> Ruby</label>
  #         </li>
  #         <li>
  #           <input type="hidden" name="post[category_ids][2]" value="">
  #           <label for="post_category_ids_2"><input id="post_category_ids_2" name="post[category_ids][2]" type="checkbox" value="2" /> Rails</label>
  #         </li>
  #       </ol>
  #     </fieldset>
  #   </li>

  # Current html
  # <div class="check_boxes">
  #   <div class="label">
  #     <label>Registro</label>
  #   </div>
  #   <input type="hidden" id="_item_type_none" value="">
  #   <div>
  #     <div class="checkbox">
  #       <input type="checkbox">
  #       <label for="item_type_todos" class="checkbox__label">Todos</label>
  #     </div>
  #     <div class="checkbox">
  #       <input type="checkbox">
  #       <label for="item_type_todos" class="checkbox__label">Todos</label>
  #     </div>
  #   </div>
  # </div>
  def check_box_without_hidden_input(choice)
    "#{super(choice)}<i class='input-helper'></i>".html_safe
  end

  def choice_wrapping_html_options(choice)
    super(choice).merge(:class => "checkbox m-b-15")
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

  def to_html
    input_wrapping do
      legend_html <<
      hidden_field_for_all <<
      error_html <<
      choices_group_wrapping do
        collection.map { |choice|
          choice_html(choice)
        }.join("\n").html_safe
      end <<
      hint_html
    end
  end

  def choice_html(choice)
    template.content_tag(
      :div,
      checkbox_input(choice) << 
      template.content_tag(
        :label, 
        choice_label(choice),
        label_html_options.merge(:for => choice_input_dom_id(choice), class: 'checkbox__label')
      ),
      class: 'checkbox'
    )
  end

  def choices_group_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block)
    )
  end

  def input_wrapping(&block)
    template.content_tag(
      :div,
      template.capture(&block),
      wrapper_html_options
    )
  end

  def wrapper_html_options
    new_class = [options[:class], super[:class]].compact.join(' ')
    super.merge(class: new_class)
  end

  def legend_html
    if render_label?
      template.content_tag(:div,
        template.content_tag(:label, label_text),
        label_html_options.merge(:class => "label")
      )
    else
      ''.html_safe
    end
  end

  def label_html_options
    super.merge(for: nil, class: 'radio__label')
  end
end
