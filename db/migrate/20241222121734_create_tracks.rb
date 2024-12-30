class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :position
      t.string :duration
      t.references :disc, null: false, foreign_key: true

      t.timestamps
    end
  end
end
