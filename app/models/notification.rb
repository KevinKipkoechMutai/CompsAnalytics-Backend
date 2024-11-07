class Notification < ApplicationRecord
    #Asscociation to the user
    belongs_to :user

    enum status: [:unread, :read, :dismissed]
    enum priority: [:high, :medium, :low]

    validates :notification_type, :title, :description, :date_and_time, presence: true
end
