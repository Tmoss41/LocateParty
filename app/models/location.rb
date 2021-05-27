class Location < ApplicationRecord
  belongs_to :profile, optional: true # Creates an association with the profile model, but also makes it an optional association so a location can exist without being attached to a profile
  belongs_to :group, optional: true #  Creates an association with the group model, but also makes it an optional association so a location can exist without being attached to a group
  validates :suburb, :state, :post_code, presence: true # Ensures that when a lcoation is being created, that the suburb, state and post_code columns are not nil and creates an error if any of them are nil
  validates :post_code, numericality: true,length: {maximum: 4, minimum: 4} # Ensures that the post_code column consists of only numbers, and that it is only 4 characters long 
end
