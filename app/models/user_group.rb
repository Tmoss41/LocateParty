class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  #  Ensures that the database queries to add users to specific groups cannot be repeated for the same user and group combination
  validates :user_id , uniqueness: { scope: [:user_id, :group_id] }
end
