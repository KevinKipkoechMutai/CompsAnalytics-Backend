class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true
    has_one :account, dependent: :destroy
    has_many :notifications
end
