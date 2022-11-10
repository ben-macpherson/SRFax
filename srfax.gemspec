# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'srfax/version'

Gem::Specification.new do |spec|
  spec.name          = "srfax"
  spec.version       = Srfax::VERSION
  spec.authors       = ["Jon Gautsch"]
  spec.email         = ["jon@workmein.com"]
  spec.summary       = %q{wrapper for the SRFax API}
  spec.description   = %q{Uses HTTMultiParty for interfacing with HelloFax to send and receive faxes, and more.}
  spec.homepage      = "https://github.com/Preferral/SRFax"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httmultiparty"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec", "~> 2.6.0"
  spec.add_development_dependency "webmock", "~> 1.18.0"
  spec.add_development_dependency "dotenv"
end
