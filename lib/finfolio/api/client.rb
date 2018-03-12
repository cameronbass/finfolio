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
require "finfolio/api/error"
require "finfolio/version"

class Finfolio::API::Client
  # Initializes a new Client object
  #
  # @param key      [String]
  # @param endpoint [String]
  # @return [Finfolio::API::Client]
  def initialize(key, endpoint)
    @key = key
    @endpoint = URI.parse(endpoint).freeze
  end

  # Get the list of Managers
  #
  # @param params [Hash] customize fields
  # @return [Array<Finfolio::API::Manager>] all the managers within api key's container.
  def managers(params = {})
    response = get("/api/manager", params)

    response.map do |manager|
      Finfolio::API::Manager.new(manager)
    end
  end

  # Get a single manager from Finfolio
  #
  # @param id [String]
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::Manager]
  def manager(id, params = {})
    response = get("/api/manager/#{id}", params)
    response = deconstruct_array(response)

    Finfolio::API::Manager.new(response)
  end

  # Get a single Account from Finfolio
  #
  # @param id [String]
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::Account]
  def account(id, params = {})
    response = get("/api/account/#{id}", params)
    response = deconstruct_array(response)

    Finfolio::API::Account.new(response)
  end

  # Get the account status of given account
  #
  # @param id [String]
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::AccountStatus]
  def account_status(id, params = {})
    response = get("/api/account/status/#{id}", params)

    Finfolio::API::AccountStatus.new(response)
  end

  # Get the subtype of a given account
  #
  # @param sub_type [String]
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::AccountType]
  def account_type(sub_type, params = {})
    response = get("/api/account/subtype/#{sub_type}", params)

    Finfolio::API::AccountType.new(response)
  end

  # Get the account value of a given account
  #
  # @param id [String]
  # @param params [Hash] customize the response fields
  #
  # @return [Finfolio::API::AccountValue]
  def account_value(id, params = {})
    response = get("/api/calculation/run/#{id}", params)
    response = deconstruct_array(response)

    Finfolio::API::AccountValue.new(response)
  end

  # Get the trading model of a given account, use ModelID found on Account
  #
  # @param id [String] the account's ModelID
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::TradingModel]
  def trading_model(id, params = {})
    response = get("/api/trading/model/#{id}", params)
    response = deconstruct_array(response)

    Finfolio::API::TradingModel.new(response)
  end

  # Get a fee schedule of a given account, use FeeScheduleID found on Account
  #
  # @param params [Hash] pass the FeeScheduleID within the params
  #
  # @return [Finfolio::API::FeeSchedule]
  def fee_schedule(params = {})
    response = get("/api/billing/feeschedule", params)
    response = deconstruct_array(response)

    Finfolio::API::FeeSchedule.new(response)
  end

  # Get a Cash value of a given account
  #
  # @param id [String]
  # @param params [Hash] customize response fields
  #
  # @return [Finfolio::API::CashValue]
  def cash_value(id, params = {})
    response = get("/api/calculation/run/#{id}", params)
    response = deconstruct_array(response)

    Finfolio::API::CashValue.new(response)
  end

  # Build a custom query from the Finfolio DB
  #
  # @param params [Hash]
  # @param ids [Array] use this to return the accounts from more than one manager
  #
  # @return [Finfolio::API::Account]
  # NOTE: This should be updated to allow different objects to be returned from Finfolio
  def view(params = {}, ids)
    if ids.any?
      params[:filter] = ids.map { |id| "ManagerID='#{id}'" }.join(" OR ")
    end

    response = get("/api/view", params)
    response.map do |account|
      Finfolio::API::Account.new(account)
    end
  end

  private

  def deconstruct_array(response)
    return unless response.is_a?(Array)

    response.first
  end

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
    when Net::HTTPInternalServerError
      raise ::Finfolio::API::InternalServerError.new(JSON.parse(response.body), response.code)
    else
      error = JSON.parse(response.body)

      raise Finfolio::API::Error.new(error, response.code)
    end
  end

  def get(path, params = {})
    uri = URI(path)

    params[:api_key] = @key
    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Get.new(uri.to_s)
    execute_request(request)
  end
end
