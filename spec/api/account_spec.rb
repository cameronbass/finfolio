require "spec_helper"
require "finfolio/api"
require "finfolio/api/account"

describe Finfolio::API::Account do
  describe "#new" do
    before do
      payload = {
        "ID" => "c2354d53d3",
        "Name" => "Test, Matthew"
      }

      @account = Finfolio::API::Account.new(payload)
    end

    it "returns a Account object" do
      expect(@account).to be_a(Finfolio::API::Account)
    end

    it "sets appropriate values" do
      expect(@account.id).to eq("c2354d53d3")
      expect(@account.name).to eq("Test, Matthew")
    end
  end
end
