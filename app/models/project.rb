class Project < ActiveRecord::Base
  belongs_to :client
  
  # State of task can be new, started, finished
  include AASM
  aasm column: :state, whiny_transitions: false  do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end

  end
  
  def possible_states
    self.aasm.states(:permitted => true).map(&:name)
  end
  
  def possible_events
    self.aasm.events.map(&:name)
  end


end
