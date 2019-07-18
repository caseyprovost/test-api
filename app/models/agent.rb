class Agent < ApplicationRecord
  has_many :licenses
  has_and_belongs_to_many :carriers

  validates :phone_number, :name, presence: true

  scope :by_industry, -> (industry_name) {
    joins(carriers: [:industries]).where(industries: { name: industry_name})
  }

  scope :licensed_in_state, -> (state) {
    joins(:licenses).where(licenses: { state: state})
  }

  scope :by_phone_number, -> (phone_number) {
    # searches by removing characters (,),.,- and matching on result
    # a better method would be to add a new column called #normalized_phone_number
    # and using an after_save hook to populate that value. This would allow us to santize
    # phone numbers more robustly. However, we are using this for now because of the following
    # test criteria: "Assume that you can not simply change the seed file with the corrected format!"
    # and the fact that fixtures insert without triggering ActiveRecord callbacks.
    where("REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone_number, '-', ''), ')', ''), '(', ''), ' ', ''), '.', '') = ?", phone_number)
  }
end
