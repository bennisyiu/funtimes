class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :name, :date, presence: true
  ## cannot create an itinerary with expired events
end
