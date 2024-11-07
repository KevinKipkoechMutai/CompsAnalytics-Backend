class Account < ApplicationRecord

    #Asscociation to the user
    belongs_to :user

    #create the logic for deducting of tokens

    def perform_valuation(view_data_count, analysis_data_count)

        #to calculate the total number of tokens to be deducted
        total_tokens = (view_data_count *10) + (analysis_data_count *15)

        #deduct tokens from tokens balance
        update(tokens: tokens - total_tokens)
    end


end
