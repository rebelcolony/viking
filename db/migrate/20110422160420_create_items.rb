class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :number
      t.string :title
      t.string :description
      t.string :price

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
