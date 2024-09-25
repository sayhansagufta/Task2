class Department < ApplicationRecord
    has_many :employees, dependent: :destroy
    has_many :spendings, dependent: :destroy
  
    validates :name, presence: true, uniqueness: true
  end
