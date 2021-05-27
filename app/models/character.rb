class Character < ApplicationRecord
  belongs_to :user # Associates the model with the User model
  validates :name, :race, :character_class, :level, presence: true # Validates that all of the columns defined in this line contain content and are not nil
  validates :level, numericality: true, inclusion: {in: 1..20, message: 'Value should be between 1 and 20'} #  Validates that what is passed to fill in the level column, consists of only numbers, and that the number passed is only between 1 and 20
  validate :validate_class, :validate_race, :validate_alignment # Runs vlaidation methods defined below in the model and ensures that they all pass before a record can be saved.StandardError


  # The below methods are all nearly identical in nature
  # They all run a check agianst an array and ensure that the column that is trying to be filled match the available options
  # If they dont, then a error is raised and displayed on the page. 
  def validate_class
    classes = ['Barbarian', 'Fighter', 'Paladin', 'Bard', 'Sorcerer', 'Warlock', 'Cleric', 'Druid', 'Monk', 'Ranger', 'Rogue']
    if !classes.include?(character_class.capitalize)
      errors.add(:character_class, ": #{character_class} is not a valid Class, please use a valid Dungeons and Dragons Class, #{classes}")
    end
  end
  def validate_alignment
    alignments = ['Chaotic Good', 'Neutral Good', 'Lawful Good', 'Chaotic Neutral', 'Neutral', 'Lawful Neutral', 'Chaotic Evil', 'Neutral Evil', 'Lawful Evil']
    if !alignments.include?(alignment)
      errors.add(:alignment, ": #{alignment} is not a valid Alignment, please use a valid Dungeons and Dragons Alignment, #{alignments}")
    end
  end
  def validate_race
    races = ['DragonBorn', 'Dwarf', 'Elf', 'Gnome','Half-Elf', 'Halfling', 'Half-Orc', 'Human', 'Tiefling']
    if !races.include?(race)
      errors.add(:race, ": #{race} is not a valid Race, please use a valid Dungeons and Dragons Race, #{races}")
    end
  end
end
