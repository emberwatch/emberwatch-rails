class CreateScreencasts < ActiveRecord::Migration[5.0]
  def change
    create_table :screencasts do |t|
      t.string :title
      t.string :url
      t.date :date
      t.text :videos, default: [].to_yaml
      t.string :series
      t.string :price
      t.string :subtitle

      t.timestamps
    end
  end
end
