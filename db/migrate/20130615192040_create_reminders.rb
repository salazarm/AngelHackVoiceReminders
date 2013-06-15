class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :description
      t.string :file
      t.datetime :playtime
      t.string :image
      t.integer :number
      t.integer :caller_id
      t.intger :callee_id

      t.timestamps
    end
  end
end
