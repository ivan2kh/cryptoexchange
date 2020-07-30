module Cryptoexchange::Exchanges
  module Kickex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Kickex::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            ticker = Cryptoexchange::Models::Ticker.new

            ticker.base      = pair['base_currency']
            ticker.target    = pair['target_currency']
            ticker.market    = Kickex::Market::NAME
            ticker.last      = pair['last_price'].to_f
            ticker.change    = pair['change_percent'].to_f
            ticker.high      = pair['high'].to_f
            ticker.low       = pair['low'].to_f
            ticker.bid      = pair['bid'].to_f
            ticker.ask       = pair['ask'].to_f
            ticker.volume    = pair['target_volume'].to_f
            ticker.timestamp = nil
            ticker.payload   = pair
            ticker
          end.compact
        end
      end
    end
  end
end
