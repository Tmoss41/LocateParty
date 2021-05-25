class RemoveColumnFromGroup < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :suburb, :string
    remove_column :groups, :state, :string
  end
end
