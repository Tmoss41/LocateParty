class Game < ApplicationRecord
  belongs_to :group # Assocaites the Game model with the Group Model
  validates :name, :date, :time, presence: true # Validates that when creating a new instance of a game, that the name, date and time fields contain content that is usable
  validate :valid_date?, unless: -> {!self.date.present?} # Runs a method to validate the date and time are in the future

  def valid_date?
    # Checks if the date is in the past
    if self.date.day < Time.now.day && self.date.month < Time.now.month && self.date.year < Time.now.year
      # If the date is in the past, passes to the errors of the model that it is in the past
      errors.add(:date, 'Cannot be in the past')
    elsif self.date.day == Time.now.day && self.date.month == Time.now.month && self.date.year == Time.now.year
      # If passes the first check and ther date is not in the past, it will then check if the date is the same day
      # if it is, then the time will be checked
      if self.time.min > Time.now.min && self.time.hour > Time.now.hour
        # If the time is in the future, nothing will be done
      else
        # if the time is in the past, then an error will be raised. 
        errors.add(:time, 'Cannot be in the past')
      end
    end
  end
end
