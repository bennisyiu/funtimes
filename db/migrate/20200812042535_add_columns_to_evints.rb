class AddColumnsToEvints < ActiveRecord::Migration[6.0]
  def change
    add_column :evints, :lng, :float
    add_column :evints, :lat, :float
  end
end
