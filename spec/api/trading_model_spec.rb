require 'spec_helper'
require 'finfolio/api'
require 'finfolio/api/trading_model'

describe Finfolio::API::TradingModel do
  describe '#new' do
    before do
      @payload = {
        'ID' => 'c2354d53d3',
        'Name' => 'Classic Income'
      }
    end

    it 'returns a TradingModel object' do
      trading_model = Finfolio::API::TradingModel.new(@payload)

      expect(trading_model).to be_a(Finfolio::API::TradingModel)
    end

    it 'sets appropriate values' do
      trading_model = Finfolio::API::TradingModel.new(@payload)

      expect(trading_model.id).to eq('c2354d53d3')
      expect(trading_model.name).to eq('Classic Income')
    end
  end
end
