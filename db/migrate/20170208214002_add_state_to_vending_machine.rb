class AddStateToVendingMachine < ActiveRecord::Migration
  def change
    add_column :vending_machines, :state, :string
  end
end
