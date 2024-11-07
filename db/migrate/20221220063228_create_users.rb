class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :phone_no
      t.string :email
      t.string :password_digest
      t.string :gender
      t.string :avatar
      t.timestamps
    end
  end
end
