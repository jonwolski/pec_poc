class CreateVendingMachines < ActiveRecord::Migration
  def change
    create_table :vending_machines do |t|

      t.timestamps null: false
    end
  end
end
