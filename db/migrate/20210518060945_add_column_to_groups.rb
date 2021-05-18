class AddColumnToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :admin_name, :string
  end
end
