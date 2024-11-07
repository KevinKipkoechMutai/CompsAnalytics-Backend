class SessionsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity_response
def create
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: :ok
        else
        render json: { error: "Invalid email or password" }, status: :unauthorized
        end
        end 
end
def destroy
    session.delete :user_id
    head :no_content
end

private 
def render_unproccessable_entity_response(error)
    render json: {errors: error.record.errors.full_message}, status: :unproccessable_entity
end
end
