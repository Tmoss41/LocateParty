class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :suburb
      t.integer :post_code
      t.string :state
      t.references :profile, null: true, foreign_key: true
      t.references :group, null: true, foreign_key: true

      t.timestamps
    end
  end
end
