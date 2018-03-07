require "spec_helper"
require "finfolio/api"
require "finfolio/api/cash_value"

describe Finfolio::API::CashValue do
  describe "#new" do
    before do
      payload = {
        "Calculator1_FormattedResult" => "$10,000.00"
      }

      @cash_value = Finfolio::API::CashValue.new(payload)
    end

    it "returns a AccountValue object" do
      expect(@cash_value).to be_a(Finfolio::API::CashValue)
    end

    it "sets appropriate values" do
      expect(@cash_value.calculated_result).to eq("$10,000.00")
    end
  end
end
