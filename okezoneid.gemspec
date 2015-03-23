# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'okezoneid/version'

Gem::Specification.new do |spec|
  spec.name          = "okezoneid"
  spec.version       = Okezoneid::VERSION
  spec.authors       = ["Adi Sukma Wibawa"]
  spec.email         = ["wibi.cms@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = %q{okezoneid for ruby}
  spec.description   = %q{Okezoneid for connecting to sso okezone}
  spec.homepage      = "https://id.okezone.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
