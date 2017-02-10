class Transition < ActiveRecord::Base
  belongs_to :vending_machine

  scope :unprocessed, -> {
    where(enqueued_at: nil, processed_at: nil, q_task_id: nil).order(:id)
  }

  class << self
    def replay_in_batches(q_task_id)
      Transition.where(q_task_id: q_task_id).group(:vending_machine_id).pluck(:vending_machine_id).each do |vending_machine_id|
        TransitionReplayJob.perform_later(q_task_id, vending_machine_id)
      end
    end

    def replay_batch(q_task_id, vending_machine_id)
      Transition.where(q_task_id: q_task_id, vending_machine_id: vending_machine_id).order(:id).each do |t|
        t.vending_machine.send("#{t.event}!".to_sym)
        t.update!(processed_at: Time.now)
      end
    end
  end


  def replay!
    TransitionReplayJob.perform_later(id, vending_machine_id)
#    replay_now!
  end

  def replay_now!
    vending_machine.send( "#{event}!".to_sym )
    update!(processed_at: Time.now)
  end

end
