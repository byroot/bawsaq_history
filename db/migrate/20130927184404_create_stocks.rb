class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :company_name
      t.string :company_code
      t.string :summary

      t.timestamps
    end
    add_index :stocks, :company_code
  end
end
