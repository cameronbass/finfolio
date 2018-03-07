require "spec_helper"
require "finfolio/api"
require "finfolio/api/account"

describe Finfolio::API::Account do
  describe "#new" do
    before do
      payload = {
        "ID" => "c2354d53d3",
        "Name" => "Test, Matthew",
        "ModelID" => "b4b5m6m4",
        "AccountStatusID" => "3m44jjjj3",
        "FeeScheduleID" => "rt4m3m3",
        "SubType" => "ACTINDIVIDUAL",
        "FolioNumber" => "9397902"
      }

      @account = Finfolio::API::Account.new(payload)
    end

    it "returns a Account object" do
      expect(@account).to be_a(Finfolio::API::Account)
    end

    it "sets appropriate values" do
      expect(@account.id).to eq("c2354d53d3")
      expect(@account.name).to eq("Test, Matthew")
      expect(@account.model_id).to eq("b4b5m6m4")
      expect(@account.account_status_id).to eq("3m44jjjj3")
      expect(@account.fee_schedule_id).to eq("rt4m3m3")
      expect(@account.sub_type).to eq("ACTINDIVIDUAL")
      expect(@account.folio_number).to eq("9397902")
    end
  end
end
