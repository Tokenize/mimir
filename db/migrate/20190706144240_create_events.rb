class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :command, null: false
      t.string :data
      t.string :description, null: false
      t.string :priority, null: false
      t.string :partition
      t.string :zone
      t.datetime :timestamp, null: false
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
