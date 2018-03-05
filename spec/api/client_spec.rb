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
           "ID": "agr0683qp4"
         },
         {
           "ID": "1234562342"
         }
       ]'
    }

    before do
      stub_request(:get, url).
        to_return(:body => response, :status => 200)
    end

    it "return a list of managers from the api" do
      client_response = client.managers

      expect(a_request(:get, url)).to have_been_made.once
      expect(client_response).to eq(JSON.parse(response))
    end

    it "returns the array of managers" do
      expect(client.managers).to be_a(Array)
    end
  end

  describe "#manager" do
    let(:id)  { 123456789 }
    let(:url) { "https://test.finfolio.com/api/manager/#{id}?api_key=12345" }

    let(:response) {
      '[
         {
           "ID": "#{id}",
           "Name": "James, LeBron",
           "RepCode": "ACFR"
         }
       ]'
    }

    before do
      stub_request(:get, url).to_return(:body => response, :status => 200)
    end

    it "returns a manager from the api" do
      client_response = client.manager(id)

      expect(a_request(:get, url)).to have_been_made.once
      expect(client_response).to eq(JSON.parse(response))
    end

    it "returns the manager as an array" do
      expect(client.manager(id)).to be_a(Array)
    end
  end
end
