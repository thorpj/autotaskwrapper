require 'yaml'

require 'autotask_api'
require_relative 'autotask/base'
require_relative 'autotask/version'

module AutotaskWrapper






end

# def read_file(path)
#   File.read(path)
# end
#
# def write_file(path, text)
#   File.open(path, 'w') do |file|
#     file.write(text)
#   end
# end




ticket_number = 'T20181221.0008'
ticket = find_ticket(ticket_number)

contact = find_contact(ticket["contactid"])
account = find_account(ticket["accountid"])

pp ticket
pp account
pp contact