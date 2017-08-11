lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "flex_struct"

Gem::Specification.new do |spec|
  spec.name     = "flex_struct"
  spec.version  = FlexStruct::VERSION
  spec.authors  = ["Gareth Adams"]
  spec.email    = ["gareth@bridge-u.com"]

  spec.summary  = %(An extension to Struct with a more flexible initializer)
  spec.homepage = "https://github.com/bridgeu/flex_struct"
  spec.license  = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.48.1"
  spec.add_development_dependency "reek", "~> 4.0"
end
