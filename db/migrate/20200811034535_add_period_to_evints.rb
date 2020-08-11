class AddPeriodToEvints < ActiveRecord::Migration[6.0]
  def change
    add_column :evints, :period, :string
  end
end
