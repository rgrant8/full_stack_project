class AddStockNameToStockUserLists < ActiveRecord::Migration
  def change
    add_column :stock_user_lists, :stock_name, :string
  end
end
