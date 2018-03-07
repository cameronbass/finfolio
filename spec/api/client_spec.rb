require "spec_helper"
require "finfolio/api/client"

describe Finfolio::API::Client do
  subject(:client) do
    Finfolio::API::Client.new("12345", "https://test.finfolio.com")
  end

  describe "#managers" do
    let(:url)   { "https://test.finfolio.com/api/manager?api_key=12345" }
    let(:response)  {
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
    }

    before do
      stub_request(:get, url).
        to_return(:body => response, :status => 200)
    end

    it "return a list of managers from the api" do
      client.managers
      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns the array of managers" do
      expect(client.managers).to be_a(Array)
    end
  end

  describe "#manager" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/manager/#{id}?api_key=12345" }

    let(:response) {
      '[
         {
           "ID": "123456789",
           "RepCode": "ACFR"
         }
       ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns a manager from the api" do
      client.manager(id)
      expect(a_request(:get, url)).to have_been_made.once
    end
  end

  describe "#account" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/account/#{id}?api_key=12345" }

    let(:response) {
      '[
        {
           "ID": "123456789",
           "Name": "Test, Name"
        }
      ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns an account from the api" do
      client.account(id)
      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an Account object" do
      client_response = client.account(id)

      expect(client_response.first).to be_a(Finfolio::API::Account)
    end
  end

  describe "#account_status" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/account/status/#{id}?api_key=12345" }

    let(:response) {
      '{
          "ID": "c2354d53d3",
          "DisplayValue": "Open"
       }'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns an account status from the api" do
      client.account_status(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an AccountStatus object" do
      client_response = client.account_status(id)

      expect(client_response).to be_a(Finfolio::API::AccountStatus)
    end
  end

  describe "#trading_model" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/trading/model/#{id}?api_key=12345" }

    let(:response) {
      '[
        {
          "ID": "c2354d53d3",
          "Name": "Individul"
        }
      ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns a trading model from the api" do
      client.trading_model(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an TradingModel object" do
      client_response = client.trading_model(id)

      expect(client_response.first).to be_a(Finfolio::API::TradingModel)
    end
  end

  describe "#account_type" do
    let(:subtype)  { "ACTINDIVIDUAL" }
    let(:url) { "https://test.finfolio.com/api/account/subtype/#{subtype}?api_key=12345" }

    let(:response) {
      '{
        "SubType": "ACTINDIVIDUAL",
        "Name": "Individul"
       }'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns an account type from the api" do
      client.account_type(subtype)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an AccountType object" do
      client_response = client.account_type(subtype)

      expect(client_response).to be_a(Finfolio::API::AccountType)
    end
  end

  describe "#fee_schedule" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/billing/feeschedule?api_key=12345&#{id}" }

    let(:response) {
      '[
        {
          "ID": "a1b2c3d4",
          "Description": "100%"
        }
      ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns a fee schedule from the api" do
      client.fee_schedule(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns a FeeSchedule object" do
      client_response = client.fee_schedule(id)

      expect(client_response.first).to be_a(Finfolio::API::FeeSchedule)
    end
  end

  describe "#account_value" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/calculation/run/#{id}?calculator1=MarketValue()&group1=Account()&api_key=12345" }

    let(:response) {
      '[
        {
          "Calculator1_FormattedResult": "100%"
        }
      ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns an account value from the api" do
      client.account_value(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an AccountValue object" do
      client_response = client.account_value(id)

      expect(client_response.first).to be_a(Finfolio::API::AccountValue)
    end
  end

  describe "#cash_value" do
    let(:id)  { "123456789" }
    let(:url) { "https://test.finfolio.com/api/calculation/run/#{id}?calculator1=MarketValue(filter: [SimpleSecType: Cash])&api_key=12345" }

    let(:response) {
      '[
        {
          "Calculator1_FormattedResult": "100%"
        }
      ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns a cash value from the api" do
      client.cash_value(id)

      expect(a_request(:get, url)).to have_been_made.once
    end

    it "returns an CashValue object" do
      client_response = client.cash_value(id)

      expect(client_response.first).to be_a(Finfolio::API::CashValue)
    end
  end
end
