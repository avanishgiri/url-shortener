class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url, :shortened
      t.integer :counter
    end
  end
end
