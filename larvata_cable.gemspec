$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "larvata_cable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "larvata_cable"
  spec.version     = LarvataCable::VERSION
  spec.authors     = ["Frank Lam"]
  spec.email       = ["ryzingsun11@yahoo.com"]
  spec.homepage    = "https://github.com/FTLam11/larvata_cable"
  spec.summary     = "Rails chat plugin using ActionCable/AnyCable"
  spec.description = "Rails chat plugin using ActionCable/AnyCable"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.1.4"

  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "spring"
  spec.add_development_dependency "spring-commands-rspec"
end
