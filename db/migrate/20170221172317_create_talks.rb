
class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.string :title
      t.string :subtitle
      t.text :videos
      t.string :url
      t.string :slides
      t.date :date

      t.timestamps
    end
  end
end
