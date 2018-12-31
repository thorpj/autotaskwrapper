module AutotaskWrapper
  class Base
    def initialize(username, password)
      @client = AutotaskAPI::Client.new do |c|
        c.basic_auth = [username, password]
        c.wsdl = 'https://webservices6.autotask.net/atservices/1.5/atws.wsdl'
        c.log = false
      end
    end


    def self.collect_attributes(entity)
      data = {}
      document = entity.raw_xml
      original_document = document.dup
      document = Nokogiri::Slop(document.to_s).children.children
      document.each do |element|
        unless element.name == "text"
          data[element.name] = element.text
        end
      end

      original_document.children.children.each do |element|
        if element.name == "UserDefinedField"
          children = element.children
          key = children[0].text
          if children.length == 2
            value = children[1].text
            data[key] = value
          else
            data[key] = nil
          end
        end
      end
      data.delete('UserDefinedFields')
      data.transform_keys do |key|
        key.underscore.gsub(" ", "_")
      end
    end

    def self.extract_numbers(string)
      string.delete("^0-9")
    end

    def self.extract_name(string)
      string.delete("0-9-")&.strip
    end
  end
end