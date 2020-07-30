module Cryptoexchange::Exchanges
  module Kickex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        # PAIRS_URL   = "#{Cryptoexchange::Exchanges::Kickex::Market::API_URL}/pairs" #do I need it?

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Kickex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
