class UserGroup < ApplicationRecord
  rolify :role_cname => 'GameRole'
  belongs_to :user
  belongs_to :group
  #  Ensures that the database queries to add users to specific groups cannot be repeated for the same user and group combination
  validates :user_id , uniqueness: { scope: [:user_id, :group_id] }
  scope :approved, -> {where(approved: true, player_approval: true) }
  scope :un_approved, -> {where(approved: false, player_approval: false) }
  scope :join_pending, -> {where(approved: false, player_approval: true)}
  scope :invite_pending, ->{where(approved: true, player_approval: false)}
end
