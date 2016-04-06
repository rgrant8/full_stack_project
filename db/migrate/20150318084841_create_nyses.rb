class CreateNyses < ActiveRecord::Migration
  def change
    create_table :nyses do |t|
      t.string :symbol
      t.string :name
      t.string :market
      t.string :country
      t.string :ipo
      t.string :sector
      t.boolean :alive
      t.string :list_type

      t.timestamps
    end
  end
end
