module ApplicationHelper
  include Pagy::Frontend

  def form_select(field, list, form, options: {})
    form.select(
      field.to_sym, 
      list,
      { include_blank: t('helpers.select.prompt') }.merge(options),
      { class: 'form-select' }
    )
  end
end
