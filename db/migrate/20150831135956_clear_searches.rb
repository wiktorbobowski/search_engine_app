class ClearSearches < ActiveRecord::Migration
  def change
    Search.delete_all
    Result.delete_all
    SearchInstance.delete_all
  end
end
