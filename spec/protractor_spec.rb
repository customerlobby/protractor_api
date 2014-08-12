require 'spec_helper'

describe Protractor::API do
  it 'should return the correct URL given the environment_mode' do
    protractor_api = Protractor::API.new("fake_connection_id","fake_api_key")
    protractor_api.get_base_url.should eq('https://integration.protractor.com/ExternalCRM/Test/GetCRMData.ashx')

    protractor_api = Protractor::API.new("fake_connection_id","fake_api_key", "production")
    protractor_api.get_base_url.should eq('https://integration.protractor.com/ExternalCRM/1.0/GetCRMData.ashx')
  end

  it 'should build_args correctly' do
    protractor_api = Protractor::API.new("fake_connection_id","fake_api_key")
    start_date = Date.new(2013,7,29)
    end_date = Date.new(2013,8,5)
    args = protractor_api.build_args(start_date, end_date)

    args["connectionID"].should eq("fake_connection_id")
    args["apiKey"].should eq("fake_api_key")
    args["startDate"].should eq(start_date)
    args["endDate"].should eq(end_date)

    protractor_api = Protractor::API.new("fake_connection_id","fake_api_key", "production")
    start_date = Date.new(2013,5,15)
    end_date = Date.new(2013,11,10)
    args = protractor_api.build_args(start_date, end_date)

    args["connectionID"].should eq("fake_connection_id")
    args["apiKey"].should eq("fake_api_key")
    args["startDate"].should eq(start_date)
    args["endDate"].should eq(end_date)
  end
end
