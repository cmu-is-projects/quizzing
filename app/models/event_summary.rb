class EventSummary < ActiveRecord::Base
  belongs_to :event
  belongs_to :division

  def self.for_event_and_division(event, division)
    where(division_id: division.id, event_id: event.id)
  end

  scope :for_division, ->(division) { where(division_id: division.id) }
  scope :chronological, -> { joins(:event).order('events.start_date') } 
end
