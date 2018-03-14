require 'spec_helper'
require 'finfolio/api'
require 'finfolio/api/account_type'

describe Finfolio::API::AccountType do
  describe '#new' do
    before do
      payload = {
        'SubType' => 'ACTINDIVIDUAL',
        'Name' => 'Individual'
      }

      @account_type = Finfolio::API::AccountType.new(payload)
    end

    it 'returns a AccountType object' do
      expect(@account_type).to be_a(Finfolio::API::AccountType)
    end

    it 'sets appropriate values' do
      expect(@account_type.sub_type).to eq('ACTINDIVIDUAL')
      expect(@account_type.name).to eq('Individual')
    end
  end
end
