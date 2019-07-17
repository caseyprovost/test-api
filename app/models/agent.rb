class Agent < ApplicationRecord
  has_many :licenses
  has_and_belongs_to_many :carriers

  validates :phone_number, :name, presence: true
end
