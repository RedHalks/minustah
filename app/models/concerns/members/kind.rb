module Members
  module Kind
    extend ActiveSupport::Concern

    included do
      enum kind: {
        rookie: 'rookie',
        official: 'official'
      }
    end
  end
end
