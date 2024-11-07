class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :notification_type
      t.string :title
      t.text :description
      t.datetime :date_and_time
      t.integer :status, default: 0
      t.string :action
      t.string :icon
      t.integer :priority, default: 0
      t.integer :user_id
      t.timestamps
    end
  end
end
