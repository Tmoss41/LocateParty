class Character < ApplicationRecord
  belongs_to :user
  validates :name, :race, :character_class, :level, presence: true
end
