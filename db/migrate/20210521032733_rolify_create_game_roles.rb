class RolifyCreateGameRoles < ActiveRecord::Migration[6.1]
  def change
    create_table(:game_roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:user_groups_game_roles, :id => false) do |t|
      t.references :user_group
      t.references :game_role
    end
    
    add_index(:game_roles, [ :name, :resource_type, :resource_id ])
    add_index(:user_groups_game_roles, [ :user_group_id, :game_role_id ])
  end
end
