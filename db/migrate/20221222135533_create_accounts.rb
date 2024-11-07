class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.integer :tokens
      t.integer :account_number
      t.string :account_email
      t.string :password_digest
      t.integer :user_id

      t.timestamps
    end
  end
end
