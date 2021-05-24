class Profile < ApplicationRecord
    belongs_to :user
    has_one :location, dependent: :destroy
    has_one_attached :avatar
    validates :first_name, :last_name, presence: true
    validates :mobile, numericality: true, length: {minimum: 10, maximum: 10}
    def full_name_to_csv
        return "#{self.first_name} #{self.last_name}"
    end
end
