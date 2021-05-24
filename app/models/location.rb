class Location < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :group, optional: true
end
