class Transition < ActiveRecord::Base
  belongs_to :vending_machine

  scope :unprocessed, -> {
    where(enqueued_at: nil, processed_at: nil, q_task_id: nil).order(:id)
  }

  def replay!
    TransitionReplayJob.perform_later(id)
#    replay_now!
  end

  def replay_now!
    vending_machine.send( "#{event}!".to_sym )
    update!(processed_at: Time.now)
  end

end
