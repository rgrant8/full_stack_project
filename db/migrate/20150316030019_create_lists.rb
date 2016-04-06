class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :symbol
      t.string :name
      t.string :market
      t.string :country
      t.string :ipo
      t.string :sector
      t.boolean :alive

      t.timestamps
    end
  end
end
