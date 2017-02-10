class TransitionReplayJob < ActiveJob::Base
  queue_as :default
  def perform(q_task_id, vending_machine_id)
    Transition.replay_batch(q_task_id, vending_machine_id)
  end

#  def perform(transition_id, vending_machine_id)
#    puts "job running for transition #{transition_id}, machine #{vending_machine_id}"
#    Transition.find(transition_id).replay_now!
#  end
end
