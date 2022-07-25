require 'rails_helper'

RSpec.describe 'departments index page' do
    it 'shows each departments name and floor' do
        dept_1 = Department.create!(name: 'Accounting', floor: 'sub-basement')
        dept_2 = Department.create!(name: 'HR', floor: '3')
        dept_3 = Department.create!(name: 'C Suite', floor: 'Penthouse')

        visit '/departments'

        within "#dept-#{dept_1.id}" do
            expect(page).to have_content("Accounting")
            expect(page).to have_content("sub-basement")
        end

        within "#dept-#{dept_2.id}" do
            expect(page).to have_content("HR")
            expect(page).to have_content("3")
        end

        within "#dept-#{dept_3.id}" do
            expect(page).to have_content("C Suite")
            expect(page).to have_content("Penthouse")
        end
    end

    it 'shows the list of employee names in each department' do
        dept_1 = Department.create!(name: 'Accounting', floor: 'sub-basement')
        dept_2 = Department.create!(name: 'HR', floor: '3')
        dept_3 = Department.create!(name: 'C Suite', floor: 'Penthouse')

        emp_1 = Employee.create!(name: 'Mark', level: 5, department_id: dept_1.id)
        emp_2 = Employee.create!(name: 'John', level: 1, department_id: dept_1.id)
        emp_3 = Employee.create!(name: 'Mary', level: 3, department_id: dept_2.id)

        visit '/departments'

        within "#dept-#{dept_1.id}" do
            expect(page).to have_content("Mark")
            expect(page).to have_content("John")
            expect(page).to_not have_content("Mary")
        end

        within "#dept-#{dept_2.id}" do
            expect(page).to_not have_content("Mark")
            expect(page).to_not have_content("John")
            expect(page).to have_content("Mary")
        end

        within "#dept-#{dept_3.id}" do
            expect(page).to_not have_content("Mark")
            expect(page).to_not have_content("John")
            expect(page).to_not have_content("Mary")
        end
    end
end