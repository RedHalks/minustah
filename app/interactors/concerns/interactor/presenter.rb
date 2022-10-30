module Interactor
  module Presenter
    extend ActiveSupport::Concern

    included do
      include Interactor
    end

    private

    def apply_list_configs(data_list)
      apply_sorting(apply_filters(data_list))
    end

    def apply_filters(data_list)
      data_list.ransack(filter_options)
    end

    def apply_sorting(ransack_search)
      ransack_search.sorts = sort_options
      ransack_search
    end

    def filter_options
      context.q || {}
    end

    def sort_options
      context.s || []
    end

    def params
      context.params || {}
    end
  end
end
