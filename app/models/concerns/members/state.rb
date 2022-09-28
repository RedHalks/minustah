module Members
  module State
    extend ActiveSupport::Concern

    included do
      enum state: {
        active: 'active',
        inactive: 'inactive',
        reserve: 'reserve'
      }, _default: 'active'
    end
  end
end
