# :nodoc:
class Finfolio::API::AccountValue
  attr_accessor :calculated_result

  def initialize(payload)
    @calculated_result = payload['Calculator1_FormattedResult']
  end
end
