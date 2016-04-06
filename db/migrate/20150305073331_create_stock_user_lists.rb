class CreateStockUserLists < ActiveRecord::Migration
  def change
    create_table :stock_user_lists do |t|
      t.references :lists, index: true
      t.references :users, index: true

      t.timestamps
    end
  end
end
