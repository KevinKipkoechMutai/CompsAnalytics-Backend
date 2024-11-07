class AddColumnsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_code, :integer
    add_column :transactions, :amount, :integer
    add_column :transactions, :account_number, :integer
    add_column :transactions, :account_name, :string
    add_column :transactions, :payment_method, :string
    add_column :transactions, :user_name, :string
    add_column :transactions, :account_id, :integer
    add_column :transactions, :user_id, :integer
  end
end
