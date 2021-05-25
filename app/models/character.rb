class Character < ApplicationRecord
  belongs_to :user
  validates :name, :race, :character_class, :level, presence: true
  validates :level, numericality: true, inclusion: {in: 1..20, message: 'Value should be between 1 and 20'}
  validate :validate_class, :validate_race, :validate_alignment
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
