class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references :itinerary, null: false, foreign_key: true
      t.references :evint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
