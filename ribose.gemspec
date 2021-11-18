# coding: utf-8

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ribose/version"

Gem::Specification.new do |spec|
  spec.name          = "ribose"
  spec.version       = Ribose::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["operations@ribose.com"]

  spec.summary       = "The Ruby interface for Ribose API"
  spec.description   = "The Ruby interface for Ribose API"
  spec.homepage      = "https://github.com/riboseinc/ribose-ruby"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.add_dependency "id_pack", "~> 1.0.1"
  spec.add_dependency "mime-types", "~> 3.3"
  spec.add_dependency "sawyer", "~> 0.8.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "webmock", "~> 3.13"
end
