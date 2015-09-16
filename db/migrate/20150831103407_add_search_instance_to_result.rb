class AddSearchInstanceToResult < ActiveRecord::Migration
  def up
    remove_column :results, :search_id, :integer
  end
  def down
    add_column :results, :search_id, :integer
  end
end
