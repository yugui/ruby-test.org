class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.string :identifier, :null => false, :unique => true
      t.datetime :committed_at, :null => false
    end
  end

  def self.down
    drop_table :revisions
  end
end
