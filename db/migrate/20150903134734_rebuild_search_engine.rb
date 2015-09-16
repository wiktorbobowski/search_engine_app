class RebuildSearchEngine < ActiveRecord::Migration
  def up
    celear_search
    remove_column :search_instances, :result_id
    remove_column :search_instances, :code
    remove_column :search_instances, :position, :integer
    create_table :search_instance_results do |t|
      t.references :search_instance
      t.references :result
      t.integer :position
      t.timestamps null: false
    end
    add_column :searches, :type, :string
  end

  def celear_search
    Search.delete_all
    Result.delete_all
    SearchInstance.delete_all
  end

  def down
    add_column :search_instances, :result_id, :integer
    add_column :search_instances, :code, :string
    add_column :search_instances, :position, :integer
    drop_table :search_instance_results
    remove_column :searches, :type, :string
  end
end
