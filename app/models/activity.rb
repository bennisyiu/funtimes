class Activity < ApplicationRecord
  belongs_to :itinerary
  belongs_to :evint

  validates :itinerary_id, :evint_id, presence: true
end
