class Group < ApplicationRecord
  has_many :games
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :approved_usergroups, -> { approved }, class_name: 'UserGroup'
  has_many :approved_users, through: :approved_usergroups, source: :user
  has_many :un_approved_usergroups, -> { un_approved }, class_name: 'UserGroup'
  has_many :un_approved_users, through: :un_approved_usergroups, source: :user
  validates :name, uniqueness: true
end
