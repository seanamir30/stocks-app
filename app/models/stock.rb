class Stock < ApplicationRecord
    belongs_to :user

    # def self.iex_api
    #     client = IEX::Api::Client.new(
    #         publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
    #         secret_token: ENV['IEX_API_SECRET_TOKEN'],
    #         endpoint: 'https://cloud.iexapis.com/v1'
    #     )
    # end
end
