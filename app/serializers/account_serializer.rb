class AccountSerializer < ActiveModel::Serializer
  attributes :id, :account_name, :tokens, :acc_no, :account_email, :user_id

  belongs_to :user
end
