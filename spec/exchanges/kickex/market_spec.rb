require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kickex::Market do
  it { expect(described_class::NAME).to eq 'kickex' }
  it { expect(described_class::API_URL).to eq 'https://ext-api.kickex.com/coingecko/api/v1' }
end
