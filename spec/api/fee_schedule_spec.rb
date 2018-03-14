require 'spec_helper'
require 'finfolio/api'
require 'finfolio/api/fee_schedule'

describe Finfolio::API::FeeSchedule do
  describe '#new' do
    before do
      payload = {
        'ID' => 'c2354d53d3',
        'Description' => '$100 Quarterly Fee'
      }

      @fee_schedule = Finfolio::API::FeeSchedule.new(payload)
    end

    it 'returns a FeeSchedule object' do
      expect(@fee_schedule).to be_a(Finfolio::API::FeeSchedule)
    end

    it 'sets appropriate values' do
      expect(@fee_schedule.id).to eq('c2354d53d3')
      expect(@fee_schedule.description).to eq('$100 Quarterly Fee')
    end
  end
end
