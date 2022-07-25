class EmployeeTicketsController < ApplicationController
    def create
        emp_ticket = EmployeeTicket.new(employee: Employee.find(ticket_params[:id]), ticket: Ticket.find(ticket_params[:ticket_id]))

        if emp_ticket.save
            redirect_to "/employees/#{params[:id]}"
        else
            redirect_to "/employees/#{params[:id]}"
            flash[:alert] = "Error: #{error_message(emp_ticket.errors)}"
        end 
    end

    private

    def ticket_params
      params.permit(:id, :ticket_id)
    end
end