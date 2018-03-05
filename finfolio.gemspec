# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finfolio/version'

Gem::Specification.new do |spec|
  spec.name          = "finfolio"
  spec.version       = Finfolio::VERSION
  spec.authors       = "Collective Idea"
  spec.email         = ["cam@collectiveidea.com"]

  spec.summary       = "Finfolio Client Library."
  spec.description   = "Interact with finfolio endpoints."
  spec.license       = "MIT"
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
