# :nodoc:
class Finfolio::API::FeeSchedule
  attr_accessor :id
  attr_accessor :description

  def initialize(payload)
    @id          = payload['ID']
    @description = payload['Description']
  end
end
