SimpleForm.setup do |config|
  config.wrappers :default, class: :input, hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.wrappers :semantic, tag: 'div', class: 'field', error_class: 'error', hint_class: 'with_hint' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.use :label_input
    b.use :hint,  wrap_with: { tag: 'div', class: 'hint' }
    b.use :error, wrap_with: { tag: 'div', class: 'ui red pointing above label error' }
  end

  config.wrappers :ui_checkbox, tag: 'div', class: 'field', error_class: 'error', hint_class: 'with_hint' do |b|
    b.use :html5
    b.wrapper tag: 'div', class: 'ui checkbox' do |input|
      input.use :label_input
      input.use :hint, wrap_with: { tag: 'div', class: 'hint' }
    end
  end

  config.wrappers :ui_slider_checkbox, tag: 'div', class: 'field', error_class: 'error', hint_class: 'with_hint' do |b|
    b.use :html5
    b.wrapper tag: 'div', class: 'ui slider checkbox' do |input|
      input.use :label_input
      input.use :hint, wrap_with: { tag: 'div', class: 'hint' }
    end
  end

  config.wrappers :ui_toggle_checkbox, tag: 'div', class: 'field', error_class: 'error', hint_class: 'with_hint' do |b|
    b.use :html5
    b.wrapper tag: 'div', class: 'ui toggle checkbox' do |input|
      input.use :label_input
      input.use :hint, wrap_with: { tag: 'div', class: 'hint' }
    end
  end

  config.default_wrapper = :semantic
  config.boolean_style = :inline
  config.button_class = 'ui primary submit button'
  config.error_method = :first
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.item_wrapper_tag = :div
  config.item_wrapper_class = 'ui checkbox'
  config.label_text = lambda { |label, required, explicit_label| label.to_s }
  config.default_form_class = 'ui form'
  config.browser_validations = false
  config.boolean_label_class = 'checkbox'
end
