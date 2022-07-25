class Employee < ApplicationRecord
  validates :name, presence: true
  validates :level, presence: true, numericality: true

  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets
  belongs_to :department
end