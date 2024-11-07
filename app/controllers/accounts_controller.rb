class AccountsController < ApplicationController
    require 'securerandom'
    #Error messages
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def index
        render json: Account.all, status: :ok 
    end

    def show
        account = Account.find(params[:id])
        render json: account, status: :ok
    end

    def create
        account = Account.create!(account_params)
        render json: account, status: :ok
    end

    def default
        account = Account.find_by(user_id: params[:user_id])
        if account.nil?
            default_acc = Account.new(default_params)
            random_code = SecureRandom.hex(10)
            default_acc.acc_no = random_code
            default_acc.tokens ="100"

            default_acc.save
            render json: default_acc, status: :ok
            
        else
          render json: {error: "Already Has an account"}, status: :unauthorized  
        end
        
    end
    # PUT
    def update
        account = Account.find(params[:id])
        account.update!(account_params)
        render json: account, status: :created
    end

    # DELETE
    def destroy
        account = Account.find(params[:id])
        account.destroy
        head :no_content
    end

    private

    def account_params
        params.permit(:account_name, :tokens, :acc_no, :account_email, :user_id)
    end

    def default_params
        params.permit(:account_name , :account_email, :user_id)
    end
    def render_404
        render json: { error: "Account not found" }, status: :not_found
    end
    
end
