require 'spec_helper'
require 'finfolio/api/client'

# rubocop:disable LineLength
describe Finfolio::API::Client do
  subject(:client) do
    Finfolio::API::Client.new('12345', 'https://test.finfolio.com')
  end

  describe '#managers' do
    let(:url) { 'https://test.finfolio.com/api/manager?api_key=12345' }
    let(:response) do
      '[
         {
           "ID": "agr0683qp4",
           "RepCode": "1234"
         },
         {
           "ID": "1234562342",
           "RepCode": "5678"
         }
       ]'
    end

    before do
      stub_request(:get, url)
        .to_return(body: response, status: 200)
    end

    it 'return a list of managers from the api' do
      client.managers
      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns the array of managers' do
      expect(client.managers).to be_a(Array)
    end
  end

  describe '#manager' do
    let(:id)  { '123456789' }
    let(:url) { "https://test.finfolio.com/api/manager/#{id}?api_key=12345" }

    let(:response) do
      '[
         {
           "ID": "123456789",
           "RepCode": "ACFR"
         }
       ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns a manager from the api' do
      client.manager(id)
      expect(a_request(:get, url)).to have_been_made.once
    end
  end

  describe '#account' do
    let(:id)  { '123456789' }
    let(:url) { "https://test.finfolio.com/api/account/#{id}?api_key=12345" }

    let(:response) do
      '[
        {
           "ID": "123456789",
           "Name": "Test, Name"
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns an account from the api' do
      client.account(id)
      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an Account object' do
      client_response = client.account(id)

      expect(client_response).to be_a(Finfolio::API::Account)
    end
  end

  describe '#account_status' do
    let(:id)  { '123456789' }
    let(:url) { "https://test.finfolio.com/api/account/status/#{id}?api_key=12345" }

    let(:response) do
      '{
          "ID": "c2354d53d3",
          "DisplayValue": "Open"
       }'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns an account status from the api' do
      client.account_status(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an AccountStatus object' do
      client_response = client.account_status(id)

      expect(client_response).to be_a(Finfolio::API::AccountStatus)
    end
  end

  describe '#trading_model' do
    let(:id) { '123456789' }
    let(:params) { { api_key: '12345' } }
    let(:url) { "https://test.finfolio.com/api/trading/model/#{id}?api_key=12345" }

    let(:response) do
      '[
        {
          "ID": "c2354d53d3",
          "Name": "Individul"
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns a trading model from the api' do
      client.trading_model(id, params)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an TradingModel object' do
      client_response = client.trading_model(id, params)

      expect(client_response).to be_a(Finfolio::API::TradingModel)
    end

    it 'returns a valid response if ID is null' do
      expect(client.trading_model(nil, params)).to eq('Null')
    end
  end

  describe '#account_type' do
    let(:subtype) { 'ACTINDIVIDUAL' }
    let(:url) { "https://test.finfolio.com/api/account/subtype/#{subtype}?api_key=12345" }

    let(:response) do
      '{
        "SubType": "ACTINDIVIDUAL",
        "Name": "Individul"
       }'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns an account type from the api' do
      client.account_type(subtype)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an AccountType object' do
      client_response = client.account_type(subtype)

      expect(client_response).to be_a(Finfolio::API::AccountType)
    end
  end

  describe '#fee_schedule' do
    let(:params) { { id: '123456789' } }
    let(:url) { 'https://test.finfolio.com/api/billing/feeschedule?id=123456789&api_key=12345' }

    let(:response) do
      '[
        {
          "ID": "a1b2c3d4",
          "Description": "100%"
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns a fee schedule from the api' do
      client.fee_schedule(params)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns a FeeSchedule object' do
      client_response = client.fee_schedule(params)

      expect(client_response).to be_a(Finfolio::API::FeeSchedule)
    end
  end

  describe '#account_value' do
    let(:id) { '123456789' }
    let(:params) { { calculator1: 'MarketValue()', group1: 'Account()' } }
    let(:url) { "https://test.finfolio.com/api/calculation/run/#{id}?calculator1=MarketValue()&group1=Account()&api_key=12345" }

    let(:response) do
      '[
        {
          "Calculator1_FormattedResult": "100%"
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns an account value from the api' do
      client.account_value(id, params)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an AccountValue object' do
      client_response = client.account_value(id, params)

      expect(client_response).to be_a(Finfolio::API::AccountValue)
    end
  end

  describe '#cash_value' do
    let(:id) { '123456789' }
    let(:params) { { calculator1: 'MarketValue(filter: [SimpleSecType: Cash])' } }
    let(:url) { "https://test.finfolio.com/api/calculation/run/#{id}?calculator1=MarketValue(filter: [SimpleSecType: Cash])&api_key=12345" }

    let(:response) do
      '[
        {
          "Calculator1_FormattedResult": "100%"
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns a cash value from the api' do
      client.cash_value(id, params)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it 'returns an CashValue object' do
      client_response = client.cash_value(id, params)

      expect(client_response).to be_a(Finfolio::API::CashValue)
    end
  end

  describe '#view' do
    let(:id) { '123456789' }
    let(:params) { { view: 'AccountsByManager', columns: 'Name, FolioNumber, ID', filter: "ManagerID='5678' OR ManagerID='1234'" } }
    let(:url) { "https://test.finfolio.com/api/view?view=AccountsByManager&columns=Name%2C%20FolioNumber%2C%20ID&filter=ManagerID%3D'5678'%20OR%20ManagerID%3D'1234'&api_key=12345" }

    let(:response) do
      '[
        {
          "Name": "Test Name", "FolioNumber": "12345", "ID": "A1B2"
        },
        {
          "Name": "Another Test Name", "FolioNumber": "67890", "ID": "C3D4" 
        }
      ]'
    end

    before do
      stub_request(:get, url).to_return(body: response, status: 200)
    end

    it 'returns the array of accounts' do
      expect(client.view(%w(5678 1234), params)).to be_a(Array)
    end

    it 'returns the list of accounts from the api' do
      response = client.view(%w(5678 1234), params)

      expect(a_request(:get, url)).to have_been_made.once
      expect(response.first).to be_a(Finfolio::API::Account)
    end
  end

  describe 'Unauthorized API Key' do
    let(:stub_url) { 'https://test.finfolio.com/api/manager?api_key=12345' }

    let(:response) do
      '{
        "Title": "Hit a Snag!",
        "FriendlyMessage": "An error occurred while attempting to get an object.",
        "DeveloperMessage": "Exception occurred during a GET on endpoint, This request does not contain a valid identity."
      }'
    end

    before do
      stub_request(:get, stub_url).to_return(body: response, status: 500)
    end

    it 'raises Error if' do
      expect { client.managers }.to raise_error(Finfolio::API::Error)
    end
  end
end
# rubocop:enable LineLength
