class TransactionsController < ApplicationController

     # Replace with your own API credentials
        SHORTCODE = "123456"
        CONSUMER_KEY = "abcdefghijklmnopqrstuvwxyz"
        CONSUMER_SECRET = "abcdefghijklmnopqrstuvwxyz"
        PASKEY = "abcdefghijklmnopqrstuvwxyz"


    #Error messages
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def index
        render json: Transaction.all, status: :ok 
    end

    def show
        transaction = Transaction.find(params[:id])
        render json: transaction, status: :ok
    end

    def create
        transaction = Transaction.create!(transaction_params)
        render json: transaction, status: :created
    end

    # PUT
    def update
        transaction = Transaction.find(params[:id])
        transaction.update!(transaction_params)
        render json: transaction, status: :created
    end

    # DELETE
    def destroy
        transaction = Transaction.find(params[:id])
        transaction.destroy
        head :no_content
    end

    private

    def transaction_params
        params.permit(:transaction_code, :amount, :acc_no, :account_name, :payment_method, :user_name)
    end

    def render_404
        render json: { error: "Transaction not found" }, status: :not_found
    end

    # Mpesa Payment
    def mpesapay
        # Generate a timestamp for the request
        timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    
        # Get an access token for the API
        access_token_response = Unirest.get("https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials",
          headers: {
            "Authorization" => "Basic #{Base64.strict_encode64("#{CONSUMER_KEY}:#{CONSUMER_SECRET}")}"
          }
        )
        access_token = access_token_response.body["access_token"]
    
        # Set the API endpoint and request headers
        api_endpoint = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
        headers = {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{access_token}"
        }
    
        # Set the request body with the necessary parameters
        request_body = {
          "BusinessShortCode" => SHORTCODE,
          "Password" => Base64.strict_encode64("#{SHORTCODE}#{PASKEY}#{timestamp}"),
          "Timestamp" => timestamp,
          "TransactionType" => "CustomerPayBillOnline",
          "Amount" => "1000",
          "PartyA" => "254700000000", # Replace with the phone number of the customer
          "PartyB" => SHORTCODE,
          "PhoneNumber" => "254700000000", # Replace with the phone number of the customer
          "CallBackURL" => "https://your-callback-url.com/mpesa/stkpush/callback",
          "AccountReference" => "123456",
          "TransactionDesc" => "Test STK Push Payment"
        }
    
        # Send the request
        response = Unirest.post(api_endpoint, headers: headers, parameters: request_body)
    
        # Check the response status
        if response.code == 200
          # STK push request was successful
          render json: { message: "STK push request successful" }
        else
          # An error occurred
          render json: { error: "An error occurred while processing the STK push request" }, status: 500
        end
      end
end
