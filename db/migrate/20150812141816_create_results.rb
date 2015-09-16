class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :search
      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
