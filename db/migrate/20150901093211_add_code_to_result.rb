class AddCodeToResult < ActiveRecord::Migration
  def change
    add_column :results, :code, :string
    add_index :results, :code, :unique => true
  end
end
