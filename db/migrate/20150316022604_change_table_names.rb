class ChangeTableNames < ActiveRecord::Migration
=begin
  
rescue Exception => e
  
end  
  def change
    
      rename_column :lists, :marketCap, :market
      rename_column :lists, :ipoYear, :ipo
      remove_column :lists, :lastSale
      remove_column :lists, :industry
      remove_column :lists, :summaryQuote
      add_column :lists, :country, :string

begin
      t.string :symbol
      t.string :name
      t.string :lastSale
      t.string :marketCap
      t.string :ipoYear
      t.string :sector
      t.string :industry
      t.string :summaryQuote
      t.timestamps
end
=end
end
