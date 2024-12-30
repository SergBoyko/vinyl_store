class CreateDiscs < ActiveRecord::Migration[7.1]
  def change
    create_table :discs do |t|
      t.string :title
      t.string :country
      t.string :released
      t.string :released_formatted
      t.string :notes
      t.string :genres, array: true
      t.string :styles, array: true

      t.references :artist, null: false, foreign_key: true
      t.string :cover_url

      t.timestamps
    end
  end
end
