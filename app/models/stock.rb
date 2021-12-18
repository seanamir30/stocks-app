class Stock < ApplicationRecord
    belongs_to :user
    has_many :trading_history

    # def self.iex_api
    #     client = IEX::Api::Client.new(
    #         publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
    #         secret_token: ENV['IEX_API_SECRET_TOKEN'],
    #         endpoint: 'https://cloud.iexapis.com/v1'
    #     )
    # end

    def self.iex_api
        IEX::Api::Client.new(
            publishable_token: 'Tsk_c5fd71d3eb484338a6820af892063bf7',
            secret_token: 'Tpk_5f449b7e58fa4bd58a68ff4ee81ec7ba',
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
    end

    

end
