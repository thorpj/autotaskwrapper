require "test_helper"

class AutotaskTest < Minitest::Test
  def setup
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '../', 'secrets.yaml'))
    @ticket_number = 'T20181221.0008'
    @autotask = Autotaskwrapper::Base.new(@config['username'], @config['password'])
    @ticket = Autotaskwrapper::Ticket.new @ticket_number
  end

  def test_that_ticket_title_exists
    assert_equal "Elitebook 810 - Won't boot, BCD error", @ticket.title
  end

  def test_display_ticket
    @ticket.to_s
  end

  def test_display_account
    @ticket.account.to_s
  end

  def test_display_contact
    @ticket.contact.to_s
  end

  def test_display_repair_completed_fields
    fields = []
    fields << @ticket.ticket_number
    fields << @ticket.account.account_name
    fields << @ticket.contact.name
    fields << @ticket.contact.phone
    fields << @ticket.contact.parent_name
    fields << @ticket.title
    fields << @ticket.resolution
    fields << @ticket.vendor
    # fields << @ticket.device_model_type
    # fields << @ticket.device_serial_number
    pp fields
  end

  def test_that_it_has_a_version_number
    refute_nil ::Autotaskwrapper::VERSION
  end




end
