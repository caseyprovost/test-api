class Policy < ApplicationRecord
  belongs_to :agent
  belongs_to :carrier
  belongs_to :industry

  validates :premium_amount, :policy_holder, presence: true
  validates :premium_amount, numericality: true, if: -> { premium_amount.present? }
end
