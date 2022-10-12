module Invoices
  module Category
    extend ActiveSupport::Concern

    included do
      enum category: {
        membership: 'membership'
      }
    end
  end
end
