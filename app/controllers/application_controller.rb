class ApplicationController < ActionController::Base
  include Pagy::Backend

  def create_success_notice
    success_notice(I18n.t('helpers.messages.success/actions.create'))
  end

  def update_success_notice
    success_notice(I18n.t('helpers.messages.success/actions.update'))
  end

  def delete_success_notice
    success_notice(I18n.t('helpers.messages.success/actions.delete'))
  end

  def success_notice(action)
    model_class = self.class.name.sub(/Controller$/, '').classify.demodulize.constantize

    name = model_class.model_name.human
    flash[:notice] = I18n.t('helpers.messages.success', action:, model: name)
  end
end
