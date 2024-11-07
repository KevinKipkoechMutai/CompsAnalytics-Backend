class CreateComparableProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :comparable_properties do |t|
      t.string :location
      t.integer :size
      t.string :category
      t.integer :value
      t.string :title

      t.timestamps
    end
  end
end
