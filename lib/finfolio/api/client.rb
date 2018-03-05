require "net/https"
require "json"

require "finfolio/api"
require "finfolio/version"

class Finfolio::API::Client
  def initialize(key, endpoint)
    @key = key
    @endpoint = URI.parse(endpoint).freeze
  end

  def managers
    get("/api/manager?api_key=#{@key}")
  end

  def manager(id)
    get("/api/manager/#{id}?api_key=#{@key}")
  end

  private

  def execute_request(request)
    http_options = {
      use_ssl: @endpoint.scheme == "https",
    }

    Net::HTTP.start(@endpoint.host, @endpoint.port, http_options) do |http|
      if request.body
        request["Content-Type"] = "application/json"
      end

      response = http.request(request)
      evaluate_response(response)
    end
  end

  def evaluate_response(response)
    case response
    when Net::HTTPNoContent
      nil
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      error = JSON.parse(response.body)

      raise error
    end
  end

  def get(path)
    path = URI.encode(path)
    request = Net::HTTP::Get.new(path)

    execute_request(request)
  end
end
