class VendingMachine < ActiveRecord::Base
  state_machine :state, initial: :a do
    event :event_a do
      transition :a => :b
    end
    event :event_b do
      transition :b => :c
    end
    event :event_c do
      transition :c => :d
    end
    event :event_d do
      transition :d => :e
    end
    event :event_e do
      transition :e => :b
    end
    event :event_e2 do
      transition :e => :f
    end
  end
end
