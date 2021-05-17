class AddColumnsToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :suburb, :string
    add_column :groups, :state, :string
  end
end
