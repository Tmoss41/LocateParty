class Character < ApplicationRecord
  belongs_to :user
  validates :name, :race, :character_class, :level, presence: true
  validates :level, numericality: true, inclusion: {in: 1..20, message: 'Value should be between 1 and 20'}
end
