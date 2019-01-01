require_relative 'entity'
require 'active_support/core_ext/object/blank'

module AutotaskWrapper
  class Ticket < AutotaskWrapper::Entity
    def initialize(id)
      @ticket = nil
      if /\A[tT]([\d]{8}).([\d]{4})\z/.match? id
        @data = find_by_ticket_number(id)
      else
        @data = find(id)
      end
    end

    def account
      @account = @account || AutotaskWrapper::Account.new(account_id)
    end

    def contact
      @contact = @contact || AutotaskWrapper::Contact.new(contact_id)
    end

    private

    def find(id)
      @ticket = AutotaskAPI::Ticket.find(id)
      AutotaskWrapper::Base.collect_attributes @ticket
    end

    def find_by_ticket_number(ticket_number, field='ticketnumber')
      @ticket = AutotaskAPI::Ticket.find(ticket_number, field)
      AutotaskWrapper::Base.collect_attributes @ticket
    end
  end

  class Contact < AutotaskWrapper::Entity
    def initialize(id)
      @ticket = nil
      @data = find(id)
    end

    def name
      "#{first_name} #{last_name}"
    end

    def phone
      result = nil
      parent_data.each do |value|
        value = AutotaskWrapper::Base.extract_numbers(value)
        if value.present?
          result = value
        end
      end
      result
    end

    def parent_name
      result = nil
      parent_data.each do |value|
        value = AutotaskWrapper::Base.extract_name(value)
        if value.present?
          result = value
        end
      end
      result
    end

    def email_address
      @data["e_mail_address"]
    end

    private

    def parent_data
      data = {
          phone: @data['phone'],
          alternate_phone: alternate_phone,
          mobile_phone: mobile_phone
      }
      found_data = []
      data.each do |key, value|
        unless value.blank?
          found_data << value
        end
      end
      found_data
    end


    def find(id)
      @contact = AutotaskAPI::Contact.find(id)
      AutotaskWrapper::Base.collect_attributes @contact
    end

  end

  class Account < AutotaskWrapper::Entity
    def initialize(id)
      @ticket = nil
      @data = find(id)
    end

    private

    def find(id)
      @account = AutotaskAPI::Account.find(id)
      AutotaskWrapper::Base.collect_attributes @account
    end

  end
end


