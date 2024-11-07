class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity_response
def index
    render json: User.all, status: :ok 
end
def create 
    user = User.create!(user_params)
    if user.valid?
    session[:user_id] = user.id
    user.save
    else
      render json: {errors: user.errors.full_message}, status: :unproccessable_entity
    end
end 
def show
    user = User.find_by(id: session[:user_id])
    if user
        render json: user
    else
     render json: {error: "Not authorized"}, status: :unauthorized  
    end
end

private
def user_params
  params.permit(:user_name, :phone_no, :email, :password, :gender, :avatar)  
end
def render_unproccessable_entity_response(error)
   render json: {errors: error.record.errors.full_message}, status: :unproccessable_entity
end


end
