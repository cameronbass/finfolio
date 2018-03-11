module Finfolio::API
  class Error < StandardError
    attr_reader :code

    def initialize(message, code = nil)
      super(message)

      @code = code
    end
  end

  class InternalServerError < Error; end
end
