class User < ApplicationRecord
  has_many :itineraries
  has_many :activities
  has_many :guests
end
