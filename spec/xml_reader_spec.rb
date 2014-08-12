require 'spec_helper'

describe Protractor::XmlReader do
  it "should return nil if there is no error" do
    reader = Protractor::XmlReader.new(successful_xml)
    reader.has_errors?.should eq(false)
  end

  it "should return the errors as an array" do
    reader = Protractor::XmlReader.new(failed_xml)
    error_description = reader.error_header
    error_description.class.should eq(Array)
    error_description.size.should eq(2)
    error_description.first.should eq('InvalidConnectionID')
    error_description[1].should eq("Invalid connection ID '00000000-0000-0000-0000-000000000000'!")
  end

  it "should return an error if it fails" do
    reader = Protractor::XmlReader.new(failed_xml)
    reader.has_errors?.should eq(true)
  end

  def failed_xml
    %{<?xml version="1.0" encoding="utf-8"?><CRMDataSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Header><ErrorNumber>InvalidConnectionID</ErrorNumber><ErrorMessage>Invalid connection ID '00000000-0000-0000-0000-000000000000'!</ErrorMessage></Header><Contacts /><ServiceItems /><Invoices /><Appointments /></CRMDataSet>}
  end

  def successful_xml
    %{<?xml version="1.0" encoding="utf-8"?><CRMDataSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Header><ErrorNumber/><ErrorMessage/></Header><Contacts /><ServiceItems /><Invoices /><Appointments /></CRMDataSet>}
  end
end
