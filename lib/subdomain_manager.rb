module SubdomainManager
	def subdomain_switched?(subd)
		session[:subdomain] != subd
	end
end