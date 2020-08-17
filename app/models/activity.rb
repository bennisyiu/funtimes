class Activity < ApplicationRecord
  belongs_to :itinerary
  belongs_to :evint
  has_many :guests

  validates :itinerary_id, :evint_id, presence: true
end
