class Location < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :group, optional: true
  validates :suburb, :state, :post_code, presence: true
  validates :post_code, numericality: true,length: {maximum: 4, minimum: 4}
end
