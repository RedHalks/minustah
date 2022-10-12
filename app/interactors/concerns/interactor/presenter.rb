module Interactor
  module Presenter
    extend ActiveSupport::Concern

    included do
      include Interactor
    end

    private

    def apply_list_configs(data_list)
      # apply_pagination(apply_sorting(apply_filters(data_list)))
      apply_sorting(apply_filters(data_list)).result
    end

    def apply_filters(data_list)
      data_list.ransack(filter_options)
    end

    def apply_sorting(ransack_search)
      ransack_search.sorts = sort_options
      ransack_search
    end

    # def apply_pagination(ransack_search)
    #   # binding.break
    #   # binding.break
    #   pagy(ransack_search.result)
    #   # ransack_search.result.page(page_options[:page]).per(page_options[:per_page])
    # end

    def filter_options
      params[:q] || {}
    end

    # def page_options
    #   params[:p] || {}
    # end

    def sort_options
      params[:s] || []
    end

    def params
      context.params || {}
    end
  end
end
