class Sbdomain
  def self.matches?(request)
  	request.subdomain.present? && request.subdomain != "www"
  end
end