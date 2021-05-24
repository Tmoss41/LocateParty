class RemoveSuburbFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :suburb, :string
  end
end
