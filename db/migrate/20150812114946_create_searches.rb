class CreateSearches < ActiveRecord::Migration
  def up
    create_table :searches do |t|
      t.column :query, :text
      t.timestamps null: false
    end
  end

  def down
    drop_table :searches
  end
end
