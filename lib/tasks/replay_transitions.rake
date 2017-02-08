desc 'replay the stored state transitions on their state machine instances'
task replay_transitions: :environment do
  q_task_id = SecureRandom.uuid
  Transition.unprocessed.update_all(enqueued_at: Time.now, q_task_id: q_task_id)
  Transition.where(q_task_id: q_task_id).each do |transition|
    transition.vending_machine.send( "#{transition.event}!".to_sym )
  end
end

