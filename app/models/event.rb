class Event < ActiveRecord::Base

  #Relationships
  has_many :quizzes

  #Validations
  # validates_presence_of :start_date, :end_date, :start_time, :num_rounds
  # validates_time :start_time, :end_time
  # validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "cannot be in the past", on:  :create
  # validates_date :end_date, :on_or_after => :start_date, :on_or_after_message => "cannot end before beginning"
  # validates_numericality_of :num_rounds, only_integer: true, greater_than: 0


  # #Scopes
  # scope :chronological, -> {order("start_date", "end_date")}
  # scope :upcoming, -> {where("start_date >= ?", Date.today)}
  # scope :past, -> {where("end_date < ?", Date.today)}
  
  # #Callbacks
  # before_destroy Proc.new {false}

  # #Methods

  # private

end
