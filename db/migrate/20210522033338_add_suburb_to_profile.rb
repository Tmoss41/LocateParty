class AddSuburbToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :suburb, :string
  end
end
