# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wsato_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "wsato_gem"
  spec.version       = WsatoGem::VERSION
  spec.authors       = ["a1616ts"]
  spec.email         = ["a1616ts@aiit.ac.jp"]

  spec.summary       = %q{20162Q Framework Class Ex. Group Work}
  spec.description   = %q{neighbor library search gem}
  spec.homepage      = "https://github.com/a1616ts/wsato_gem/wiki"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
