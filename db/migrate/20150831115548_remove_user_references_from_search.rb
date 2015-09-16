class RemoveUserReferencesFromSearch < ActiveRecord::Migration
  def up
    remove_column :searches, :user_id
    create_table :users_searches do |t|
      t.references :user
      t.references :search
      t.timestamps null: false
    end
  end

  def down
    add_column :searches, :user_id, :integer
    drop_table :users_searches
  end
end
