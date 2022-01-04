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
            publishable_token: ENV['PUBLISHABLE_TOKEN']
            secret_token: ENV['SECRET_TOKEN'],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
    end

    
end
