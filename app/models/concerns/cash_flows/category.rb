module CashFlows
  module Category
    extend ActiveSupport::Concern

    included do
      enum category: {
        membership: 'membership',
        donation: 'donation',
        other: 'other',
        mission: 'mission'
      }
    end

    def input_categories
      %i[membership donation other]
    end

    def output_categories
      %i[mission other]
    end
  end
end
