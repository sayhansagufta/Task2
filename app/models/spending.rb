class Spending < ApplicationRecord
    belongs_to :employee
    belongs_to :department
  
    validates :date, presence: true
    validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end