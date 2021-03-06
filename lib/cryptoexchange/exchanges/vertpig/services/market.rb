module Cryptoexchange::Exchanges
  module Vertpig
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
          "#{Cryptoexchange::Exchanges::Vertpig::Market::API_URL}/public/getmarketsummaries"
        end

        def adapt_all(output)
          output['result'].map do |ticker|
            target      = ticker['MarketPairing']
            base        = ticker['MarketName'].gsub(/#{target}\z/, '')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Vertpig::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Vertpig::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.high      = NumericHelper.to_d(output['High24hr'])
          ticker.low       = NumericHelper.to_d(output['Low24hr'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
