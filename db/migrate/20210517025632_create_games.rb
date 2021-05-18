class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.date :date
      t.time :time
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
