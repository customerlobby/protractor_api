module Protractor
  # XmlReader is used to encapsulate as much as possible the resulting XML.
  # It does this by converting it to a Nokogiri NodeSet.
  # Also provides some starter methods for parsing out data (customers, invoices, etc.)
  class XmlReader
    attr_accessor :nokogiri_xml
    def initialize(xml_string)
      @nokogiri_xml = Nokogiri::XML(xml_string)
    end

    # @returns [boolean] based on whether there are error messages in teh header
    def has_errors?
      error_header != nil
    end

    # @returns [Array] an Array with length 2 containing the error_number and error_message, otherwise nil
    def error_header
      error_number = @nokogiri_xml.xpath("//CRMDataSet/Header/ErrorNumber").text
      error_message = @nokogiri_xml.xpath("//CRMDataSet/Header/ErrorMessage").text

      if error_number.size > 0 or error_message.size > 0
        return [error_number, error_message]
      end

      return nil
    end

    # @returns Nokogiri NodeSet representing contacts
    def contacts
      @nokogiri_xml.xpath("//CRMDataSet/Contacts/Item")
    end

    # @returns Nokogiri NodeSet representing transactions
    def invoices
      @nokogiri_xml.xpath("//CRMDataSet/Invoices/Item")
    end

    # @returns Nokogiri NodeSet representing vehicles
    def vehicles
      @nokogiri_xml.xpath("//CRMDataSet/ServiceItems/Item")
    end
  end
end
