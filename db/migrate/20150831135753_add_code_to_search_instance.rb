class AddCodeToSearchInstance < ActiveRecord::Migration
  def change
    add_column :search_instances, :code, :string
  end
end
