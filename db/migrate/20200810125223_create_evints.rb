class CreateEvints < ActiveRecord::Migration[6.0]
  def change
    create_table :evints do |t|
      t.string :title
      t.string :evint_link
      t.string :venue
      t.string :address
      t.string :category
      t.string :time
      t.string :area
      t.string :description
      t.string :image_link
      t.string :date
      t.string :phone
      t.string :wechatid

      t.timestamps
    end
  end
end
