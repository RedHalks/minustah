module CashFlows
  module Category
    extend ActiveSupport::Concern

    included do
      enum category: {
        membership: 'membership',
        donation: 'donation',
        other: 'other',
        mission: 'mission',
        revenue: 'revenue'
      }
    end

    def input_categories
      %i[membership donation revenue other]
    end

    def output_categories
      %i[mission other]
    end
  end
end
