# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_changes'

Gem::Specification.new do |spec|
  spec.name          = "test_changes"
  spec.version       = TestChanges::VERSION
  spec.authors       = ["George Mendoza"]
  spec.email         = ["gsmendoza@gmail.com"]

  spec.summary       = TestChanges::SUMMARY
  spec.description   = TestChanges::DESCRIPTION

  spec.homepage      = "https://github.com/gsmendoza/test_changes"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", '~> 4.2.0'

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
