50.times do
  VendingMachine.create
end

VendingMachine.order(:id).limit(40).each &:'event_a!'
VendingMachine.order(:id).limit(30).each &:'event_b!'
VendingMachine.order(:id).limit(20).each &:'event_c!'
VendingMachine.order(:id).limit(10).each &:'event_d!'
VendingMachine.order(:id).limit( 5).each &:'event_e!'
VendingMachine.with_state(:e).first.event_e2!

VendingMachine.with_state(:a).each do |vm|
  Transition.create(vending_machine: vm, event: :event_a)
  Transition.create(vending_machine: vm, event: :event_b)
  Transition.create(vending_machine: vm, event: :event_c)
  Transition.create(vending_machine: vm, event: :event_d)
  Transition.create(vending_machine: vm, event: :event_e)
end
VendingMachine.with_state(:b).each do |vm|
  Transition.create(vending_machine: vm, event: :event_b)
  Transition.create(vending_machine: vm, event: :event_c)
  Transition.create(vending_machine: vm, event: :event_d)
  Transition.create(vending_machine: vm, event: :event_e)
end
VendingMachine.with_state(:c).each do |vm|
  Transition.create(vending_machine: vm, event: :event_c)
  Transition.create(vending_machine: vm, event: :event_d)
  Transition.create(vending_machine: vm, event: :event_e)
end
VendingMachine.with_state(:d).each do |vm|
  Transition.create(vending_machine: vm, event: :event_d)
  Transition.create(vending_machine: vm, event: :event_e)
end
VendingMachine.with_state(:e).each do |vm|
  Transition.create(vending_machine: vm, event: :event_e)
end
VendingMachine.with_states(%i[a b c d e]).each do |vm|
  Transition.create(vending_machine: vm, event: :event_b)
  Transition.create(vending_machine: vm, event: :event_c)
  Transition.create(vending_machine: vm, event: :event_d)
  Transition.create(vending_machine: vm, event: :event_e2)
end

