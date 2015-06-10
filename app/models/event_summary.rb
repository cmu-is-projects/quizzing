class EventSummary < ActiveRecord::Base
  belongs_to :event
  belongs_to :division

  scope :for_division, ->(division) { where(division_id: division.id) }
  scope :chronological, -> { joins(:event).order('events.start_date') } 
end
