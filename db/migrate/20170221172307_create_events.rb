class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :name
      t.string :site

      t.timestamps
    end
  end
end
