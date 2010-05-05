class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.string :identifier, :null => false, :unique => true
      t.text :name, :null => false
      t.references :first_appeared_at, :null => false
    end
  end

  def self.down
    drop_table :parts
  end
end
