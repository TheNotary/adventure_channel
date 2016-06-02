# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adventure_channel/version'

Gem::Specification.new do |spec|
  spec.name          = "adventure_channel"
  spec.version       = AdventureChannel::VERSION
  spec.authors       = ["TheNotary"]
  spec.email         = ["no@email.plz"]

  spec.summary       = %q{An IRC channel game}
  spec.description   = %q{An IRC channel game}
  spec.homepage      = "https://github.com/TheNotary/adventure_channel"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "cinch", "2.3.1"
  spec.add_dependency "figaro", "1.1.1"
  # spec.add_dependency "activerecord", "4.2.5.2"
  spec.add_dependency "redis-objects"
  spec.add_dependency "ohm"


  spec.add_development_dependency "bundler", "1.12.4"
  spec.add_development_dependency "rake", "11.1.2"
  spec.add_development_dependency "rspec", "3.4.0"
  spec.add_development_dependency "pry"
end
