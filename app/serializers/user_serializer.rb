class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :phone_no, :email, :avatar, :gender
  has_one :account, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
