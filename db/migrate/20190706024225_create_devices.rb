class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name, null: false
      t.string :uuid, null: false
      t.references :user, foreign_key: true
      t.datetime :last_seen_at

      t.timestamps
    end
  end
end
