module Cryptoexchange::Exchanges
  module Kickex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Kickex::Market::API_URL}/historical_trades?ticker_id=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["trade_id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["type"]
            tr.price     = trade["price"].to_f
            tr.amount    = trade["amount"].to_f
            tr.timestamp = trade["timestamp"] / 1000
            tr.payload   = trade
            tr.market    = Kickex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
