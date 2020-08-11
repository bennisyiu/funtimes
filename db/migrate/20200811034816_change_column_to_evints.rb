class ChangeColumnToEvints < ActiveRecord::Migration[6.0]
  def change
    change_column :evints, :date, 'date USING CAST(date AS date)'
  end
end
