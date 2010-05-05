class CreateBundlings < ActiveRecord::Migration
  def self.up
    create_table :bundlings do |t|
      t.references :of, null: false
      t.references :in, null: false

      t.index %w[ of in ], unique: true
    end
  end

  def self.down
    drop_table :bundlings
  end
end
