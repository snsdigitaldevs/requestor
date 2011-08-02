# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "requestor/version"

Gem::Specification.new do |s|
  s.name        = "requestor"
  s.version     = Requestor::VERSION
  s.authors     = ["Dev Team"]
  s.email       = ["digital.developers@simonandschuster.com"]
  s.homepage    = ""
  s.summary     = %q{Rolling up all our requestors and logging}
  s.description = %q{Rollling up all out requestors and logging}

  #s.rubyforge_project = "requestor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  #s.add_dependency 'active_support'
end
