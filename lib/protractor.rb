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

    def get_xml(start_date, end_date)
      args = build_args(start_date, end_date)

      url = "#{get_base_url}?#{to_query(args)}"

      require 'open-uri'
      open(url).read
    end

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

    def get_base_url
      @environment_mode == "production" ? BASE_PRODUCTION_URL : BASE_DEVELOPMENT_URL
    end

    def to_query(hash)
      hash.map do |k, v|
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      end.join("&")
    end
  end
end
