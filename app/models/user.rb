class User < ApplicationRecord
  has_many :itineraries
  has_many :activities
end
