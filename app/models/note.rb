class Note < ActiveRecord::Base
  belongs_to :project
  
  # State of note can be active, archived, finished
  include AASM
  aasm column: :state, whiny_transitions: false  do
    state :active, initial: true
    state :archived
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      after do
        self.finished_at = Time.now
      end
      
      transitions from: :active, to: :finished
    end
    
    event :delete do
      after do
        self.archived_at = Time.now
      end
      
      transitions from: [:active,:finished], to: :archived
    end

  end
end
