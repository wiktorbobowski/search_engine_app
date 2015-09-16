class CreateSearchInstances < ActiveRecord::Migration
  def change
    create_table :search_instances do |t|
      t.references :search
      t.references :result

      t.timestamps null: false
    end
  end
end
