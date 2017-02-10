desc 'replay the stored state transitions on their state machine instances'
task replay_transitions: :environment do
#  Transition.replay_in_batches!
  Transition.replay_all!
end

desc 'load more transitions for replay'
task load_transitions: :environment do
  VendingMachine.with_states(%i[a b c d e]).each do |vm|
    Transition.create(vending_machine: vm, event: :event_b)
    Transition.create(vending_machine: vm, event: :event_c)
    Transition.create(vending_machine: vm, event: :event_d)
    Transition.create(vending_machine: vm, event: :event_e2)
  end
end

