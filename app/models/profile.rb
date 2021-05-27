class Profile < ApplicationRecord
    belongs_to :user
    # Has One Relations
    has_one :location, dependent: :destroy
    has_one_attached :avatar
    # Validations
    validates :first_name, :last_name, presence: true
    validates :mobile, numericality: true, length: {minimum: 10, maximum: 10}

    def full_name_to_csv # Gets the first name and last name columns and creates a string to render full name of the profile 
        return "#{self.first_name} #{self.last_name}"
    end
end
