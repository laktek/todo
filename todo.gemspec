# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo/version'

Gem::Specification.new do |spec|
  spec.name          = "todo"
  spec.version       = Todo::VERSION
  spec.authors       = ["Lakshan Perera", "Aniket Pant", "Dennis Theisen"]
  spec.email         = ["lakshanlaktek.com"]
  spec.description   = %q{simple command line todo list manager}
  spec.summary       = %q{simple command line todo list manager}
  spec.homepage      = %q{http://github.com/laktek/todo}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "main", ">= 2.8.2"
  spec.add_runtime_dependency "highline", ">= 1.4.0"
end
