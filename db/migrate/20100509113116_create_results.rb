class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.references :report, null: false
      t.references :part, null: false
      t.boolean :succeeded, null: false
      t.string :description, null: false
      t.text :detail

      t.integer :position, null: false

      t.timestamps
      t.index %w[ result_id position ], unique: true
    end
  end

  def self.down
    drop_table :results
  end
end
