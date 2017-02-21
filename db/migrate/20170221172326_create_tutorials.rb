class CreateTutorials < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :urls
      t.date :date
      t.string :code
      t.date :date_updated
      t.date :date_created
      t.text :versions
      t.string :demo

      t.timestamps
    end
  end
end
