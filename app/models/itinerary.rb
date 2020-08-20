class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :guests
  has_many :users, through: :guests

  validates :name, :date, presence: true
  ## cannot create an itinerary with expired events
end
