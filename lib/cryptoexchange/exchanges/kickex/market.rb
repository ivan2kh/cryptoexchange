module Cryptoexchange::Exchanges
  module Kickex
    class Market < Cryptoexchange::Models::Market
      NAME = 'kickex'
      API_URL = 'https://ext-api.kickex.com/coingecko/api/v1'

      def self.trade_page_url(args={})
        "https://ext-api.kickex.com/coingecko/api/v1/historical_trades?ticker_id=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
