class AddColumnToUserGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :user_groups, :player_approval, :boolean
  end
end
