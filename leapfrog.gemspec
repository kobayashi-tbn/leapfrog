# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "leapfrog/version"

Gem::Specification.new do |s|
  s.name        = "leapfrog"
  s.version     = Leapfrog::VERSION
  s.authors     = ["kobayashi-tbn"]
  s.email       = ["kobayashi.tbn@gmail.com"]
  s.homepage    = "https://github.com/kobayashi-tbn/leapfrog"
  s.summary     = %q{Auto setting for Created_by and Updated_by columns}
  s.description = %q{DB Migration and Model helper}

  # s.rubyforge_project = "leapfrog"

  s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('activerecord')
end
