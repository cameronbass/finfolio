class Finfolio::API::AccountType
  attr_accessor :sub_type
  attr_accessor :name

  def initialize(payload)
    @sub_type = payload["SubType"]
    @name     = payload["Name"]
  end
end
