# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'childsplay/version'

Gem::Specification.new do |spec|
  spec.name          = "childsplay"
  spec.version       = Childsplay::VERSION
  spec.authors       = ["Brian Haberer"]
  spec.email         = ["bhaberer@gmail.com"]
  spec.description   = %q{Library to interface with the Child's Play API.}
  spec.summary       = %q{Child's Play API}
  spec.homepage      = "https://github.com/bhaberer/childsplay"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency       'typhoeus',   '~> 0.6.5'
end
