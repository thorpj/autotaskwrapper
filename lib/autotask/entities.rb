module AutotaskWrapper
  class Ticket < AutotaskWrapper::Entity
    def initialize(ticket_number)
      @data = find_ticket(ticket_number)
    end

    def initialize_by_id(id)
      ticket = AutotaskAPI::Ticket.find(id)
      AutotaskWrapper::Base.collect_attributes ticket
    end

    private

    def find_ticket(id, field='ticketnumber')
      ticket = AutotaskAPI::Ticket.find(id, field)
      AutotaskWrapper::Base.collect_attributes ticket
    end
  end
end

