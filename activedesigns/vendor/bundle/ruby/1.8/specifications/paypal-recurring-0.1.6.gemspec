# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{paypal-recurring}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Nando Vieira}]
  s.date = %q{2011-07-11}
  s.description = %q{PayPal Express Checkout API Client for recurring billing.}
  s.email = [%q{fnando.vieira@gmail.com}]
  s.homepage = %q{http://rubygems.org/gems/paypal-recurring}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{PayPal Express Checkout API Client for recurring billing.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<vcr>, ["~> 1.10"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.6"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<vcr>, ["~> 1.10"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.6"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<vcr>, ["~> 1.10"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
  end
end
