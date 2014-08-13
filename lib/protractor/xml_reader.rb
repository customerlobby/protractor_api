module Protractor
  class XmlReader
    attr_accessor :nokogiri_xml
    def initialize(xml_string)
      @nokogiri_xml = Nokogiri::XML(xml_string)
    end

    def has_errors?
      error_header != nil
    end

    def error_header
      error_number = @nokogiri_xml.xpath("//CRMDataSet/Header/ErrorNumber").text
      error_message = @nokogiri_xml.xpath("//CRMDataSet/Header/ErrorMessage").text

      if error_number.size > 0 or error_message.size > 0
        return [error_number, error_message]
      end

      return nil
    end

    def contacts
      @nokogiri_xml.xpath("//CRMDataSet/Contacts/Item")
    end

    def invoices
      @nokogiri_xml.xpath("//CRMDataSet/Invoices/Item")
    end
  end
end
