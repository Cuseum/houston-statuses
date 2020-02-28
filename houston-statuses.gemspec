$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/statuses/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "houston-statuses"
  spec.version       = Houston::Statuses::VERSION
  spec.authors       = ["mbajur"]
  spec.email         = ["mbajur@gmail.com"]

  spec.summary       = "Write a short summary, because Rubygems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://cuseum.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.test_files = Dir["test/**/*"]

  spec.add_dependency "houston-core", ">= 0.9.2"

  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "rake", "~> 10.0"
end
