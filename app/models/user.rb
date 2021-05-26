class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :characters, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :approved_usergroups, -> { approved }, class_name: 'UserGroup'
  has_many :approved_groups, through: :approved_usergroups, source: :group
  has_many :un_approved_usergroups, -> { un_approved }, class_name: 'UserGroup'
  has_many :un_approved_groups, through: :un_approved_usergroups, source: :group
  has_many :join_pending_usergroups, -> { join_pending }, class_name: 'UserGroup'
  has_many :join_pending_groups, through: :join_pending_usergroups, source: :group
  has_many :invite_pending_usergroups, -> { invite_pending }, class_name: 'UserGroup'
  has_many :invite_pending_groups, through: :invite_pending_usergroups, source: :group
  has_one :profile, dependent: :destroy
  
end