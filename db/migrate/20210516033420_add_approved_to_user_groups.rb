class AddApprovedToUserGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :user_groups, :approved, :boolean, :default => true
  end
end
