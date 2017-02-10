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
    if VendingMachine.sleep_enabled?
      sp = sleep_period
      Rails.logger.info "Sleeping for #{sp}"
      sleep sp
    else
      Rails.logger.info "Sleeping disabled"
    end
    Rails.logger.info "machine ##{id} in state :#{state} processed"
  end

  class << self
    def enable_sleep!
      @sleep_enabled = true
    end

    def disable_sleep!
      @sleep_enabled = false
    end
    def sleep_enabled?
      if @sleep_enabled.nil?
        @sleep_enabled = true
      end
      @sleep_enabled
    end
  end

  private

  def sleep_period
    (0xf - state_name_to_int) * 100 * MILLISECONDS + 4 * SECONDS
  end

  def state_name_to_int
    state.to_s.to_i(16)
  end

  SECONDS = 1
  MILLISECONDS = 0.001
end
