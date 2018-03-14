# :nodoc:
class Finfolio::API::View
  attr_accessor :id
  attr_accessor :name

  def initialize(payload)
    @id   = payload['ID']
    @name = payload['Name']
  end
end
