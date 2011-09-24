# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "platonic_config/version"

Gem::Specification.new do |s|
  s.name        = "platonic_config"
  s.version     = PlatonicConfig::VERSION
  s.authors     = ["Ryan Sorensen"]
  s.email       = ["rcsorensen@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "platonic_config"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "simplecov"
  s.add_development_dependency "rspec"
end
