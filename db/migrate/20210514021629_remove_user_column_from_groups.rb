class RemoveUserColumnFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :user_id
  end
end
