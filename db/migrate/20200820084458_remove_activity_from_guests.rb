class RemoveActivityFromGuests < ActiveRecord::Migration[6.0]
  def change
    remove_reference :guests, :activity, null: false, foreign_key: true
    add_reference :guests, :itinerary, null: false, foreign_key: true
  end
end
