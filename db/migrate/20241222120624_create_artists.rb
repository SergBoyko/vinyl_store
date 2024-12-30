class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :profile
      t.string :name_variations, array: true, default: []

      t.timestamps
    end
  end
end
