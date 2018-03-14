# :nodoc:
class Finfolio::API::AccountStatus
  attr_accessor :id
  attr_accessor :display_value

  def initialize(payload)
    @id            = payload['ID']
    @display_value = payload['DisplayValue']
  end
end
