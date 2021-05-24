class Group < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :approved_usergroups, -> { approved }, class_name: 'UserGroup'
  has_many :approved_users, through: :approved_usergroups, source: :user
  has_many :un_approved_usergroups, -> { un_approved }, class_name: 'UserGroup'
  has_many :un_approved_users, through: :un_approved_usergroups, source: :user
  has_many :join_pending_usergroups, -> { join_pending }, class_name: 'UserGroup'
  has_many :join_pending_users, through: :join_pending_usergroups, source: :user
  has_many :invite_pending_usergroups, -> { invite_pending }, class_name: 'UserGroup'
  has_many :invite_pending_users, through: :invite_pending_usergroups, source: :user
  validates :name, :suburb, :state, presence: true
  validates :name, uniqueness: true
  has_many_attached :group_images
  
end
