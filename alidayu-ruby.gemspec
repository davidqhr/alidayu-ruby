# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alidayu/version'

Gem::Specification.new do |spec|
  spec.name          = "alidayu-ruby"
  spec.version       = Alidayu::VERSION
  spec.authors       = ["david"]
  spec.email         = ["davidqhr@gmail.com"]

  spec.summary       = %q{阿里大鱼发送短信ruby sdk}
  spec.description   = %q{阿里大鱼发送短信ruby sdk}
  spec.homepage      = "https://github.com/davidqhr/alidayu-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
