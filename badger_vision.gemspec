
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "badger_vision/version"

Gem::Specification.new do |spec|
  spec.name          = "badger_vision"
  spec.version       = BadgerVision::VERSION
  spec.authors       = ["Hendrik Kleinwaechter"]
  spec.email         = ["hendrik.kleinwaechter@gmail.com"]

  spec.summary       = %q{Ruby wrapper for the Places365 image detection algorithm.}
  spec.description   = %q{Allows you to understand for a given image what is going on there.}
  spec.homepage      = "https://github.com/hendricius/badger_vision"
  spec.licenses      = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0"

  spec.add_dependency "faraday", "~> 0"
end
