require "net/https"
require "json"

require "finfolio/api"
require "finfolio/api/manager"
require "finfolio/api/account"
require "finfolio/api/account_status"
require "finfolio/api/account_type"
require "finfolio/api/account_value"
require "finfolio/api/fee_schedule"
require "finfolio/api/trading_model"
require "finfolio/api/cash_value"
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

    response.map do |manager|
      Finfolio::API::Manager.new(manager)
    end
  end

  def account(id)
    response = get("/api/account/#{id}?api_key=#{@key}")

    response.map do |account|
      Finfolio::API::Account.new(account)
    end
  end

  def account_status(id)
    response = get("/api/account/status/#{id}?api_key=#{@key}")

    Finfolio::API::AccountStatus.new(response)
  end

  def account_type(sub_type)
    response = get("/api/account/subtype/#{sub_type}?api_key=#{@key}")

    Finfolio::API::AccountType.new(response)
  end

  def account_value(id)
    response = get("/api/calculation/run/#{id}?calculator1=MarketValue()&group1=Account()&api_key=#{@key}")

    response.map do |account_value|
      Finfolio::API::AccountValue.new(account_value)
    end
  end

  def trading_model(id)
    response = get("/api/trading/model/#{id}?api_key=#{@key}")

    response.map do |trading_model|
      Finfolio::API::TradingModel.new(trading_model)
    end
  end

  def fee_schedule(id)
    response = get("/api/billing/feeschedule?api_key=#{@key}&#{id}")

    response.map do |fee_schedule|
      Finfolio::API::FeeSchedule.new(fee_schedule)
    end
  end

  def cash_value(id)
    response = get("/api/calculation/run/#{id}?calculator1=MarketValue(filter: [SimpleSecType: Cash])&api_key=#{@key}")

    response.map do |cash_value|
      Finfolio::API::CashValue.new(cash_value)
    end
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
