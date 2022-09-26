module People
  module BloodType
    extend ActiveSupport::Concern

    included do
      enum blood_type: {
        a_plus: 'A+',
        a_minus: 'A-',
        b_plus: 'B+',
        b_minus: 'B-',
        o_plus: 'O+',
        o_minus: 'O-',
        ab_plus: 'AB+',
        ab_minus: 'AB-'
      }
    end
  end
end
