class AddDetailsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :symbol, :string
    add_column :feeds, :name, :string
    add_column :feeds, :bid, :decimal
    add_column :feeds, :year_high, :decimal
    add_column :feeds, :year_low, :decimal
  end
end
