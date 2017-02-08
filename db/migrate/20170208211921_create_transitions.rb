class CreateTransitions < ActiveRecord::Migration
  def change
    create_table :transitions do |t|
      t.integer :vending_machine_id
      t.string :event
      t.datetime :enqueued_at
      t.datetime :processed_at
      t.uuid :q_task_id

      t.timestamps null: false
    end
  end
end
