module ApplicationHelper
  include Pagy::Frontend

  def form_select(field, list, form)
    form.select field.to_sym, list, { include_blank: t('helpers.select.prompt') }, { class: 'form-select' }
  end

  def form_select_enum(field, enum_list, form)
    form_select(field, enum_list, form)
  end
end
