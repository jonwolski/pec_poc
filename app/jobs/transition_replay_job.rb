class TransitionReplayJob < ActiveJob::Base
  queue_as :default

  def perform(transition_id)
    Transition.find(transition_id).replay_now!
  end
end
