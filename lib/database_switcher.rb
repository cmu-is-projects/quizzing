module DatabaseSwitcher
  def determine_correct_database
    compare_subdomain_with_session(request.subdomain)
    connect_to_db(session[:subdomain])
  end

  def compare_subdomain_with_session(subdomain=nil)
    subdomain = verify_subdomain(subdomain)  
    session[:subdomain] = subdomain
  end

  def verify_subdomain(subdomain)
    allowed_subdomains = ['westpa', 'pgh', 'erie', 'altoona', 'ovd', 'central', 'greatlakes', 'pnw', 'cmd', 'westcanada', 'metro', 'centralcanada']
    if subdomain.blank?
      return "auth"
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