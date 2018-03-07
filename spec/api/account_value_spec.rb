require "spec_helper"
require "finfolio/api"
require "finfolio/api/account_value"

describe Finfolio::API::AccountValue do
  describe "#new" do
    before do
      payload = {
        "Calculator1_FormattedResult" => "$10,000.00"
      }

      @account_value = Finfolio::API::AccountValue.new(payload)
    end

    it "returns a AccountValue object" do
      expect(@account_value).to be_a(Finfolio::API::AccountValue)
    end

    it "sets appropriate values" do
      expect(@account_value.calculated_result).to eq("$10,000.00")
    end
  end
end
