class CreateDelayedJobSettings < ActiveRecord::Migration
  def change
    create_table :delayed_job_settings do |t|
      t.integer :interval

      t.timestamps null: false
    end
  end
end
