# :nodoc:
class Finfolio::API::TradingModel
  attr_accessor :id
  attr_accessor :name

  def initialize(payload)
    @id   = payload['ID']
    @name = payload['Name']
  end
end
