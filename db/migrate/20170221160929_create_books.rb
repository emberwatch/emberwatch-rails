class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :publisher
      t.string :url
      t.string :payment

      t.timestamps
    end
  end
end
