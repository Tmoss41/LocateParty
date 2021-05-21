class RemoveColumnFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :admin_name, :string
  end
end
