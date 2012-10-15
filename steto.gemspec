# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "steto/version"

Gem::Specification.new do |s|
  s.name        = "steto"
  s.version     = Steto::VERSION
  s.authors     = ["Alban Peignier", "Florent Peyraud"]
  s.email       = ["alban@tryphon.eu", "florent@tryphon.eu"]
  s.homepage    = "https://github.com/tryphon/steto"
  s.summary     = %q{Check system status}
  s.description = %q{Ruby engine to check system status (with Nagios or custom checks)}

  s.rubyforge_project = "steto"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "RedCloth"

  s.add_runtime_dependency "cocaine", "0.2.1"
  s.add_runtime_dependency "parallel"
  s.add_runtime_dependency "json"
end
