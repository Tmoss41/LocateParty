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
end