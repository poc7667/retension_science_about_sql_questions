class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :eid
      t.datetime :dt

      t.timestamps null: false
    end
  end
end
