class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_code, :amount, :account_name, :acc_no, :payment_method, :user_name
end
