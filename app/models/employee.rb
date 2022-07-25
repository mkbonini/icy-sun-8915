class Employee < ApplicationRecord
  validates :name, presence: true
  validates :level, presence: true, numericality: true

  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets
  belongs_to :department

  def tickets_by_age
    tickets.order("age DESC")
  end

  def oldest_ticket
    tickets_by_age.first
  end
end