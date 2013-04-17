# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtools/version'

Gem::Specification.new do |spec|
  spec.name          = "gtools"
  spec.version       = Gtools::VERSION
  spec.authors       = ["Kamil Kocemba"]
  spec.email         = ["kamil@futureworkshops.com"]
  spec.description   = %{A set of Gooogle SEO tools in Ruby}
  spec.summary       = %q{Gathers statistics like PageRank, site index, page speed analysis and more.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rdoc'

  spec.add_runtime_dependency "httparty", "~> 0.11.0"

end
