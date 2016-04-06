class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :info

      t.timestamps
    end
  end
end
