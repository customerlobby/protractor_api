require "protractor/version"
require "protractor/xml_reader"
require 'nokogiri'

module Protractor
  class API
    attr_accessor :connection_id, :api_key, :environment_mode

    BASE_DEVELOPMENT_URL = "https://integration.protractor.com/ExternalCRM/Test/GetCRMData.ashx"
    BASE_PRODUCTION_URL  = "https://integration.protractor.com/ExternalCRM/1.0/GetCRMData.ashx"

    def initialize(connection_id, api_key, environment_mode='development')
      @connection_id = connection_id
      @api_key = api_key
      @environment_mode = environment_mode
    end

    # gets the XML through the API (actually makes the network connection)
    # @params [Date] start_date the beginning date for our target data
    # @params [Date] end_date the ending date for our target data
    # @returns [String] XML formatted as specified by API
    def get_xml(start_date, end_date)
      args = build_args(start_date, end_date)

      url = "#{get_base_url}?#{to_query(args)}"

      require 'open-uri'
      open(url).read
    end

    # helper method to build an array or required fields for API call
    # @params [Date] start_date the beginning date for our target data
    # @params [Date] end_date the ending date for our target data
    # @returns [Hash] hash containing all the required parameters for an API call
    def build_args(start_date, end_date)
      unless @environment_mode == "production"
        start_date = Date.new(2013,7,29)
        end_date = Date.new(2013,8,5)
      end

      {
        "connectionID" => @connection_id,
        "apiKey"       => @api_key,
        "startDate"    => start_date,
        "endDate"      => end_date,
      }
    end

    # Uses environmnet mode to get the correct URL to access (production vs. other)
    # @returns [String] target URL
    def get_base_url
      @environment_mode == "production" ? BASE_PRODUCTION_URL : BASE_DEVELOPMENT_URL
    end

    # helper method to turn a hash into a query string
    # @param [Hash] hash of params to turn into a query string
    # @return [String] of format args1=value1&args2=value2
    def to_query(hash)
      hash.map do |k, v|
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      end.join("&")
    end
  end
end
