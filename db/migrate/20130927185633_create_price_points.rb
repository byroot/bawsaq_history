class CreatePricePoints < ActiveRecord::Migration
  def change
    create_table :price_points do |t|
      t.references :stock
      t.float :price

      t.timestamps
    end
  end
end
