class AddPriceAndConditionToDiscs < ActiveRecord::Migration[7.1]
  def change
    add_column :discs, :price, :integer
    add_column :discs, :condition, :string
  end
end
