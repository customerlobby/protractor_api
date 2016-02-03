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

  it 'should return an enumeration of contacts' do
    reader = Protractor::XmlReader.new(hardcoded_xml)
    reader.contacts.count.should eq(1)
    reader.contacts.respond_to?(:each).should eq(true)
    reader.contacts.xpath("ID").text.should eq('c7939c57-c67c-4c33-bc33-56cb85dcfa10')
    reader.contacts.xpath("Name/FirstName").text.should eq('Smitty')
    reader.contacts.xpath("Address/City").text.should eq('Toronto')
  end

  it 'should return an enumeration of invoices' do
    reader = Protractor::XmlReader.new(hardcoded_xml)
    reader.invoices.count.should eq(1)
    reader.invoices.respond_to?(:each).should eq(true)
    reader.invoices.xpath("ID").text.should eq('94b91992-0583-4e89-83d1-3a9377c56262')
    reader.invoices.xpath("Summary/GrandTotal").text.should eq('1192.6900')
  end

  it 'should return an enumeration of vehicles' do
    reader = Protractor::XmlReader.new(hardcoded_xml)
    reader.vehicles.count.should eq(1)
    reader.vehicles.respond_to?(:each).should eq(true)
    reader.vehicles.xpath("ID").text.should eq('ccdb63ef-c462-444a-8656-0d19f7aa4371')
    reader.vehicles.xpath("Make").text.should eq('GMC')
  end

  def failed_xml
    %{<?xml version="1.0" encoding="utf-8"?><CRMDataSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Header><ErrorNumber>InvalidConnectionID</ErrorNumber><ErrorMessage>Invalid connection ID '00000000-0000-0000-0000-000000000000'!</ErrorMessage></Header><Contacts /><ServiceItems /><Invoices /><Appointments /></CRMDataSet>}
  end

  def successful_xml
    %{<?xml version="1.0" encoding="utf-8"?><CRMDataSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Header><ErrorNumber/><ErrorMessage/></Header><Contacts /><ServiceItems /><Invoices /><Appointments /></CRMDataSet>}
  end

  def hardcoded_xml
    <<-EOS
    <CRMDataSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <Header>
      <ErrorNumber/>
      <ErrorMessage/>
    </Header>
    <Contacts>
      <Item>
        <Header>
          <ID>c7939c57-c67c-4c33-bc33-56cb85dcfa10</ID>
          <CreationTime>2014-02-28T15:39:32.177-05:00</CreationTime>
          <DeletionTime>0001-01-01T00:00:00</DeletionTime>
          <LastModifiedTime>2014-07-10T18:04:51.2-04:00</LastModifiedTime>
          <LastModifiedBy>Test\Lei</LastModifiedBy>
        </Header>
        <ID>c7939c57-c67c-4c33-bc33-56cb85dcfa10</ID>
        <FileAs>CarQuest With ePartExpert</FileAs>
        <Name>
          <Title>Known As</Title>
          <Prefix/>
          <FirstName>Smitty</FirstName>
          <MiddleName/>
          <LastName/>
          <Suffix/>
        </Name>
        <Address>
          <Title>Home</Title>
          <Street>999 Some Street</Street>
          <City>Toronto</City>
          <Province>ON</Province>
          <PostalCode/>
          <Country>USA</Country>
        </Address>
        <Company>CarQuest With ePartExpert</Company>
        <Phone1Title>Business 2</Phone1Title>
        <Phone1>+1 (416) 686-3114</Phone1>
        <Phone2Title>Business</Phone2Title>
        <Phone2>(905) 666-7779</Phone2>
        <EmailTitle>Home</EmailTitle>
        <Email>lei@protractor.com</Email>
        <AdditionalURIs>
          <Item>
            <Title>Home</Title>
            <Type>Email</Type>
            <Address>lei@protractor.com</Address>
          </Item>
          <Item>
            <Title>Business</Title>
            <Type>Email</Type>
            <Address>test@abc.com</Address>
          </Item>
          <Item>
            <Title>Business</Title>
            <Type>WebPage</Type>
            <Address>http://www.Protractor.com</Address>
          </Item>
        </AdditionalURIs>
        <AdditionalPhones>
          <Item>
            <Title>Business 2</Title>
            <Number>686-3114</Number>
          </Item>
          <Item>
            <Title>Business</Title>
            <Number>666-7779</Number>
          </Item>
          <Item>
            <Title>Fax</Title>
            <Number>456-7890</Number>
          </Item>
          <Item>
            <Title>Business 2</Title>
            <Number>333-4441</Number>
          </Item>
          <Item>
            <Title>Home 2</Title>
            <Number>663-4343</Number>
          </Item>
          <Item>
            <Title>Other</Title>
            <Number>456-7890</Number>
          </Item>
          <Item>
            <Title>Home</Title>
            <Number/>
          </Item>
        </AdditionalPhones>
        <Note/>
        <NoEmail>false</NoEmail>
        <NoPostCard>false</NoPostCard>
      </Item>
    </Contacts>
    <ServiceItems>
      <Item>
        <Header>
          <ID>ccdb63ef-c462-444a-8656-0d19f7aa4371</ID>
          <CreationTime>2013-07-19T13:58:11.163-04:00</CreationTime>
          <DeletionTime>0001-01-01T00:00:00</DeletionTime>
          <LastModifiedTime>2014-04-28T22:01:14.863-04:00</LastModifiedTime>
          <LastModifiedBy>Test\Lei</LastModifiedBy>
        </Header>
        <ID>ccdb63ef-c462-444a-8656-0d19f7aa4371</ID>
        <Type>Vehicle</Type>
        <Lookup>6795AX</Lookup>
        <Description>2007 GMC Sierra 1500 Classic SL</Description>
        <Usage>18000</Usage>
        <ProductionDate>0001-01-01T00:00:00</ProductionDate>
        <NoEmail>false</NoEmail>
        <NoPostCard>false</NoPostCard>
        <OwnerID>c7939c57-c67c-4c33-bc33-56cb85dcfa10</OwnerID>
        <PlateRegistration>TX</PlateRegistration>
        <VIN>2GTEK13T471104369</VIN>
        <Color>Black</Color>
        <Year>2007</Year>
        <Make>GMC</Make>
        <Model>Sierra 1500</Model>
        <Submodel>Classic SL</Submodel>
        <Engine>V8 5.3L 5328CC 325CI</DEngine>
      </Item>
    </ServiceItems>
    <Invoices>
      <Item>
        <Header>
          <ID>94b91992-0583-4e89-83d1-3a9377c56262</ID>
          <CreationTime>2012-07-04T05:33:58.123-04:00</CreationTime>
          <DeletionTime>0001-01-01T00:00:00</DeletionTime>
          <LastModifiedTime>2013-07-31T17:53:14.557-04:00</LastModifiedTime>
          <LastModifiedBy>Test\yang</LastModifiedBy>
        </Header>
        <ID>94b91992-0583-4e89-83d1-3a9377c56262</ID>
        <Type>WorkOrder</Type>
        <ScheduledTime>2012-07-04T04:40:24.52-04:00</ScheduledTime>
        <PromisedTime>2012-07-04T04:40:24.52-04:00</PromisedTime>
        <InvoiceTime>2012-07-05T02:07:11.833-04:00</InvoiceTime>
        <WorkOrderNumber>239</WorkOrderNumber>
        <InvoiceNumber>91</InvoiceNumber>
        <PurchaseOrderNumber/>
        <ContactID>b6e1b583-ce4d-4455-b2d8-a4d0182d7ac7</ContactID>
        <ServiceItemID>610e8285-efcc-43fb-ac6f-9109cefc516f</ServiceItemID>
        <Technician>Test Employee</Technician>
        <ServiceAdvisor>Wang, Yang Protractor</ServiceAdvisor>
        <InUsage>8000</InUsage>
        <OutUsage>8000</OutUsage>
        <Note/>
        <ServicePackages>
          <Item>...</Item>
        </ServicePackages>
        <DeferredServicePackages/>
        <Summary>
          <PartsTotal>876.2200</PartsTotal>
          <LaborTotal>162.0000</LaborTotal>
          <SubletTotal>0.0000</SubletTotal>
          <NetTotal>1038.2200</NetTotal>
          <OtherCharges>
            <Item>
              <ID>b7475599-9697-43c4-9702-559c21af50c2</ID>
              <Code>J</Code>
              <Name>Environmental Fee</Name>
              <Value>19.50</Value>
            </Item>
            <Item>
              <ID>5bc28a49-23ac-418f-83f9-e57f5279b460</ID>
              <Code>H</Code>
              <Name>Canadian Harmonized Sales Tax</Name>
              <Value>134.97</Value>
            </Item>
          </OtherCharges>
          <GrandTotal>1192.6900</GrandTotal>
        </Summary>
        <OtherChargeCode/>
        <LocationID>9e2c9ec7-8e7b-4724-8190-edae181d91eb</LocationID>
      </Item>
    </Invoices>
    <Appointments/>
  </CRMDataSet>
  EOS
  end
end
