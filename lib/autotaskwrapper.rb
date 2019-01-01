require 'yaml'
require 'autotask_api'

require_relative 'autotaskwrapper/base'
require_relative 'autotaskwrapper/entities'
require_relative 'autotaskwrapper/entity'
require_relative 'autotaskwrapper/version'

module AutotaskWrapper

  # def read_file(path)
  #   File.read(path)
  # end
  #
  # def write_file(path, text)
  #   File.open(path, 'w') do |file|
  #     file.write(text)
  #   end
  # end
  def self.test_repair_complete_fields
    config = YAML.load_file(File.join(File.dirname(__FILE__), '../', 'secrets.yaml'))
    ticket_number = 'T20181221.0008'
    autotask = AutotaskWrapper::Base.new(config['username'], config['password'])
    ticket = AutotaskWrapper::Ticket.new ticket_number
    fields = {
      ticket: ticket.ticket_number,
      account_name: ticket.account.account_name,
      contact_name: ticket.contact.name,
      contact_phone: ticket.contact.phone,
      contact_email: ticket.contact.email_address,
      parent_name: ticket.contact.parent_name,
      title: ticket.title,
      resolution: ticket.resolution,
      vendor: ticket.vendor,
      model: ticket.device_model_type,
      serial_number: ticket.device_serial_number
    }
  end
end








