class Finfolio::API::Account
  attr_accessor :id
  attr_accessor :name
  attr_accessor :model_id
  attr_accessor :sub_type
  attr_accessor :account_status_id
  attr_accessor :fee_schedule_id
  attr_accessor :folio_number

  def initialize(payload)
    @id                = payload["ID"]
    @name              = payload["Name"]
    @folio_number      = payload["FolioNumber"]
    @fee_schedule_id   = payload["FeeScheduleID"]
    @account_status_id = payload["AccountStatusID"]
    @sub_type          = payload["SubType"]
    @model_id          = payload["ModelID"]
  end
end
