class AddPostionionToSearchInstance < ActiveRecord::Migration
  def change
    add_column :search_instances, :position, :integer
  end
end
