require "net/https"
require "json"

require "finfolio/api"
require "finfolio/api/manager"
require "finfolio/version"

class Finfolio::API::Client
  def initialize(key, endpoint)
    @key = key
    @endpoint = URI.parse(endpoint).freeze
  end

  def managers
    response = get("/api/manager?api_key=#{@key}")

    response.map do |manager|
      Finfolio::API::Manager.new(manager)
    end
  end

  def manager(id)
    response = get("/api/manager/#{id}?api_key=#{@key}")
    Finfolio::API::Manager.new(response)
  end

  def account(id)
    response = get("/api/account/#{id}?api_key=#{@key}")

    Finfolio::API::Account.new(response)
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
