require 'spec_helper'
require 'finfolio/api'
require 'finfolio/api/manager'

describe Finfolio::API::Manager do
  describe '#new' do
    before do
      payload = {
        'ID' => 'c2354d53d3',
        'RepCode' => 'ABCD'
      }

      @manager = Finfolio::API::Manager.new(payload)
    end

    it 'returns a Manager object' do
      expect(@manager).to be_a(Finfolio::API::Manager)
    end

    it 'sets appropriate values' do
      expect(@manager.id).to eq('c2354d53d3')
      expect(@manager.rep_code).to eq('ABCD')
    end
  end
end
