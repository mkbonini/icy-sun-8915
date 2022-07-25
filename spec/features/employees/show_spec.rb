require 'rails_helper'

RSpec.describe 'employee show page' do
    it 'shows the employees name and department' do
        dept = Department.create!(name: 'Accounting', floor: 'sub-basement')
        dept_2 = Department.create!(name: 'HR', floor: '3')

        emp_1 = Employee.create!(name: 'Mark', level: 5, department_id: dept.id)
        emp_2 = Employee.create!(name: 'John', level: 1, department_id: dept.id)

        visit "/employees/#{emp_1.id}"

        within "#employee-info" do
            expect(page).to have_content("Mark")
            expect(page).to have_content("Accounting")
            expect(page).to_not have_content("John")
            expect(page).to_not have_content("HR")
        end
    end

    it ' shows the employee tickets from oldest to youngest' do
        dept = Department.create!(name: 'Accounting', floor: 'sub-basement')
        emp = Employee.create!(name: 'Mark', level: 5, department_id: dept.id)

        ticket_old = Ticket.create!(subject: "bad chair", age: 5)
        ticket_new = Ticket.create!(subject: "printer broken", age: 1)
        ticket_mid = Ticket.create!(subject: "fridge smell", age: 3)

        EmployeeTicket.create!(employee: emp, ticket: ticket_old)
        EmployeeTicket.create!(employee: emp, ticket: ticket_new)
        EmployeeTicket.create!(employee: emp, ticket: ticket_mid)

        visit "/employees/#{emp.id}"

        within "#ticket-list" do
            expect(page.text.index('bad chair')).to be < page.text.index('fridge smell')
            expect(page.text.index('fridge smell')).to be < page.text.index('printer broken')
        end
    end

    it 'has the oldest ticket listed seperately' do
        dept = Department.create!(name: 'Accounting', floor: 'sub-basement')
        emp = Employee.create!(name: 'Mark', level: 5, department_id: dept.id)

        ticket_old = Ticket.create!(subject: "bad chair", age: 5)
        ticket_new = Ticket.create!(subject: "printer broken", age: 1)
        ticket_mid = Ticket.create!(subject: "fridge smell", age: 3)

        EmployeeTicket.create!(employee: emp, ticket: ticket_old)
        EmployeeTicket.create!(employee: emp, ticket: ticket_new)
        EmployeeTicket.create!(employee: emp, ticket: ticket_mid)
        
        visit "/employees/#{emp.id}"

        within "#oldest-ticket" do
            expect(page).to have_content("bad chair")
        end
    end
end