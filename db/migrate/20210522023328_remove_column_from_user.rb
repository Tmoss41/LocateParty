class RemoveColumnFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :profile, null: false, foreign_key: true
  end
end
