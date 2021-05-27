class Game < ApplicationRecord
  belongs_to :group # Assocaites the Game model with the Group Model
  validates :name, :date, :time, presence: true # Validates that when creating a new instance of a game, that the name, date and time fields contain content that is usable
  validate :valid_date?# Runs a method to validate the date and time are in the future
  def valid_time?
    return self.time <= Time.now
  end
  def valid_date?
    # Checks if the date is in the past
    if self.date < Time.now
      # If the date is in the past, passes to the errors of the model that it is in the past
      errors.add(:date, 'Cannot be in the past')
    elsif self.date == Time.now
       if valid_time?
        errors.add(:time, 'Cannot be in the past')
       end
    end
  end
end
