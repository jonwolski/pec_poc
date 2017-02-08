class Transition < ActiveRecord::Base
  belongs_to :vending_machine

  scope :unprocessed, -> {
    where(enqueued_at: nil, processed_at: nil, q_task_id: nil).order(:id)
  }
end
