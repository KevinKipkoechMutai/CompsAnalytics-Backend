class NotificationsController < ApplicationController
    before_action :set_notification, only: [:show, :update, :destroy]

    def index
      notifications = Notification.all
      render json: notifications, each_serializer: NotificationSerializer
    end
  
    def show
      render json: @notification, serializer: NotificationSerializer
    end
  
    def create
      notification = Notification.new(notification_params)
  
      if notification.save
        render json: notification, serializer: NotificationSerializer, status: :created
      else
        render json: notification.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @notification.update(notification_params)
        render json: @notification, serializer: NotificationSerializer
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @notification.destroy
    end
  
    private
  
    def set_notification
      @notification = Notification.find(params[:id])
    end
  
    def notification_params
      params.require(:notification).permit(:notification_type, :title, :description, :date_and_time, :status, :action, :icon, :priority, :user_id)
    end
end
