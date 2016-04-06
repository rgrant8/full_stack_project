class CreateStockInfos < ActiveRecord::Migration
  def change
    create_table :stock_infos do |t|
      t.string :symbol
      t.string :name
      t.decimal :bid
      t.decimal :ask
      t.decimal :year_high
      t.decimal :year_low

      t.timestamps
    end
  end
end
