module DatabaseSwitcher
  def determine_correct_database
    compare_subdomain_with_session(request.subdomain)
    connect_to_db(session[:subdomain])
  end

  def compare_subdomain_with_session(subdomain=nil)
    subdomain = verify_subdomain(subdomain)  
    session[:subdomain] = subdomain
  end

  def verify_database(db_name)
    current_databases = SETTINGS[:database_list]
    if current_databases.include?(db_name)
      return true
    else
      raise Exceptions::ConnectionNotEstablished
    end
  end

  def verify_subdomain(subdomain)
    allowed_subdomains = SETTINGS[:database_list]
    if subdomain.blank?
      return "quizzing"
    elsif allowed_subdomains.include?(subdomain)
      return subdomain
    else
      raise Exceptions::NoDatabaseExists
    end
  end

  def connect_to_db(db)
    config = ActiveRecord::Base.configurations["#{Rails.env}"].merge("database" => "#{db}")
    ActiveRecord::Base.establish_connection(config)
  end
end