require "spec_helper"
require "finfolio/api"
require "finfolio/api/account_status"

describe Finfolio::API::AccountStatus do
  describe "#new" do
    before do
      payload = {
        "ID" => "c2354d53d3",
        "DisplayValue" => "Open"
      }

      @account_status = Finfolio::API::AccountStatus.new(payload)
    end

    it "returns a AccountStatus object" do
      expect(@account_status).to be_a(Finfolio::API::AccountStatus)
    end

    it "sets appropriate values" do
      expect(@account_status.id).to eq("c2354d53d3")
      expect(@account_status.display_value).to eq("Open")
    end
  end
end
