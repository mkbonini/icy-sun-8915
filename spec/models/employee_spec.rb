require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many(:tickets)}
    it { should have_many(:tickets).through(:employee_tickets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:level) }
    it { should validate_numericality_of(:level) }
  end
  
  describe 'methods' do
    it 'should return the oldest ticket' do
      dept = Department.create!(name: 'Accounting', floor: 'sub-basement')
        emp = Employee.create!(name: 'Mark', level: 5, department_id: dept.id)

        ticket_old = Ticket.create!(subject: "bad chair", age: 5)
        ticket_new = Ticket.create!(subject: "printer broken", age: 1)
        ticket_mid = Ticket.create!(subject: "fridge smell", age: 3)

        EmployeeTicket.create!(employee: emp, ticket: ticket_old)
        EmployeeTicket.create!(employee: emp, ticket: ticket_new)
        EmployeeTicket.create!(employee: emp, ticket: ticket_mid)

        expect(emp.oldest_ticket).to eq(ticket_old)
    end

    it 'should return the tickets oldest to youngest' do
      dept = Department.create!(name: 'Accounting', floor: 'sub-basement')
      emp = Employee.create!(name: 'Mark', level: 5, department_id: dept.id)

      ticket_old = Ticket.create!(subject: "bad chair", age: 5)
      ticket_new = Ticket.create!(subject: "printer broken", age: 1)
      ticket_mid = Ticket.create!(subject: "fridge smell", age: 3)

      EmployeeTicket.create!(employee: emp, ticket: ticket_old)
      EmployeeTicket.create!(employee: emp, ticket: ticket_new)
      EmployeeTicket.create!(employee: emp, ticket: ticket_mid)

      expect(emp.tickets_by_age).to eq([ticket_old, ticket_mid, ticket_new])
    end
  end
end