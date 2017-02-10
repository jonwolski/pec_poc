class TransitionReplayJob < ActiveJob::Base
  queue_as :default
#  def perform(vending_machine_id)
#    Transition.replay_batch!(vending_machine_id)
#  end

  def perform(transition_id, vending_machine_id, event_id)
    t = Transition.find(transition_id)
    puts "job running for transition #{transition_id}, machine #{t.vending_machine_id}, event #{t.event}"
    t.replay_now!
  end
end
