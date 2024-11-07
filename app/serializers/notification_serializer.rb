class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :notification_type, :title, :description, :date_and_time, :status, :action, :icon, :priority, :user_id
  belongs_to :user
end
