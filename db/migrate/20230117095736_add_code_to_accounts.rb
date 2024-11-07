class AddCodeToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :acc_no, :string
  end
end
