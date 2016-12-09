class Project < ActiveRecord::Base
  validates :client, presence: true 
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 } 
 
  # State of task can be new, started, finished
  include AASM
  aasm column: :state, whiny_transitions: false  do
    state :new, initial: true
    state :started
    state :finished
    state :archived

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      after do
        self.finished_at = Time.now
      end
      
      transitions from: :started, to: :finished
    end
    
    event :delete do
      after do
        self.archived_at = Time.now
      end
      
      transitions from: [:new,:started,:finished], to: :archived
    end

  end
  
  def possible_states
    self.aasm.states(:permitted => true).map(&:name)
  end
  
  def possible_events
    self.aasm.events.map(&:name)
  end

 def perform_event state_name
   return false if state_name.blank?
   if Project.events_names.include? state_name.try(:to_sym)
     unless self.send("may_#{state_name}?")
       self.errors.add(:event, "can't to be apply")
       false
     else
       self.send state_name
       true
     end
   else
     self.errors.add(:event, "don't exists")
     false
   end
 end
 
 def Project.events_names
   Project.aasm.events.map(&:name)
 end

end
