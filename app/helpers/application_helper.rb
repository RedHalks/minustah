module ApplicationHelper
  def form_select_enum(field, enum_list, form)
    form.select field.to_sym, enum_list, { include_blank: t('helpers.select.prompt') }, { class: 'form-select' }
  end
end
