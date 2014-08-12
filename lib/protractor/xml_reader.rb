module Protractor
  class XmlReader
    attr_accessor :nokogiri_slop
    def initialize(xml_string)
      @nokogiri_slop = Nokogiri::Slop(xml_string)
    end

    def has_errors?
      error_header != nil
    end

    def error_header
      error_number = @nokogiri_slop.CRMDataSet.Header.ErrorNumber.text
      error_message = @nokogiri_slop.CRMDataSet.Header.ErrorMessage.text

      if error_number.size > 0 or error_message.size > 0
        return [error_number, error_message]
      end

      return nil
    end
  end
end
