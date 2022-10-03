class ApplicationController < ActionController::Base
  def success_notice
    model_class = self.class.name.sub(/Controller$/, '').classify.constantize

    name = model_class.model_name.human
    flash[:notice] = I18n.t('helpers.messages.success', model: name)
  end
end
