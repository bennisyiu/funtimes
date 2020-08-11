class AddVenueLinkToEvints < ActiveRecord::Migration[6.0]
  def change
    add_column :evints, :venue_link, :string
  end
end
