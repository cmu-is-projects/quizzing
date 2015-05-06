class NullOrganization
  def name
    "N/A"
  end

  def short_name
    "N/A"
  end

  def street_1
    "N/A"
  end

  def street_2
    "N/A"
  end

  def city
    "N/A"
  end

  def state
    "N/A"
  end

  def zip
    "N/A"
  end

  def latitude
    0.0000
  end

  def longitude
    0.0000
  end

  def active
    false
  end

  def inactive
    true    
  end  

  def primary_contact
    NullCoach.new
  end

  def students
    [NullStudent.new]
  end

  def teams
    [NullTeam.new]
  end

  def coaches
    [NullCoach.new]
  end

  def current_students
    [NullStudent.new]
  end

end