# -*- encoding: utf-8 -*-
# stub: knock 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "knock".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Arnaud MESUREUR".freeze, "Ghjuvan-Carlu BIANCHI".freeze]
  s.date = "2017-02-11"
  s.description = "Authentication solution for Rails based on JWT".freeze
  s.email = ["arnaud.mesureur@gmail.com".freeze]
  s.homepage = "https://github.com/nsarno/knock".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.3".freeze
  s.summary = "Seamless JWT authentication for Rails API.".freeze

  s.installed_by_version = "2.7.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.2"])
      s.add_runtime_dependency(%q<jwt>.freeze, ["~> 1.5"])
      s.add_runtime_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 4.2"])
      s.add_dependency(%q<jwt>.freeze, ["~> 1.5"])
      s.add_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 4.2"])
    s.add_dependency(%q<jwt>.freeze, ["~> 1.5"])
    s.add_dependency(%q<bcrypt>.freeze, ["~> 3.1"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
  end
end
