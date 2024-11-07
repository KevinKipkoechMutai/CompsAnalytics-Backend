class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :image
      t.string :lr_no
      t.string :location
      t.string :category
      t.string :analysis
      t.text :description
      t.string :title
      t.integer :size
      t.integer :value
      t.integer :user_id
      t.timestamps
    end
  end
end
