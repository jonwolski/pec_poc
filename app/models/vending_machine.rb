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
    after_transition on: any - [:a], do: :process
  end

  def process
    Rails.logger.info "machine ##{id} in state :#{state} processing"
    sleep sleep_period
    Rails.logger.info "machine ##{id} in state :#{state} processed"
  end
  private

  def sleep_period
    (state_name_to_int - 10) * 10# * MILLISECONDS
  end

  def state_name_to_int
    state.to_s.to_i(16)
  end

  MILLISECONDS = 0.001
end
