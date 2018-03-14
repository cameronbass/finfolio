# :nodoc:
class Finfolio::API::Manager
  attr_accessor :id
  attr_accessor :rep_code

  def initialize(payload)
    @id       = payload['ID']
    @rep_code = payload['RepCode']
  end
end
