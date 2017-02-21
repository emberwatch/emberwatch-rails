class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.integer :old_id
      t.string :shortname
      t.string :name
      t.string :github
      t.string :slack
      t.string :twitter
      t.string :slideshare
      t.string :speakerdeck
      t.string :site
      t.string :company

      t.timestamps
    end
  end
end
