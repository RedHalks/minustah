module ApplicationHelper
  include Pagy::Frontend

  def form_select(field, list, form)
    form.select field.to_sym, list, { include_blank: t('helpers.select.prompt') }, { class: 'form-select' }
  end
end
