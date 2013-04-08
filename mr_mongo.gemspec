# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mr_mongo/version'

Gem::Specification.new do |spec|
  spec.name          = "mr_mongo"
  spec.version       = MrMongo::VERSION
  spec.authors       = ["Yuya Takeyama"]
  spec.email         = ["sign.of.the.wolf.pentagram@gmail.com"]
  spec.description   = %q{MapReduce framework for MongoDB using Ruby DSL}
  spec.summary       = %q{MapReduce framework for MongoDB using Ruby DSL}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongo", "~> 1.8.4"
  spec.add_dependency "bson_ext", "~> 1.8.4"
  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_dependency "multi_json", "~> 1.7.2"
  spec.add_dependency "inline_template_loader", "~> 0.3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "guard-rspec", "~> 2.5.2"
  spec.add_development_dependency "rb-fsevent", "~> 0.9.1"
  spec.add_development_dependency "coveralls", "~> 0.6.4"
end
