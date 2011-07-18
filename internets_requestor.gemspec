# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "internets_requestor/version"

Gem::Specification.new do |s|
  s.name        = "internets_requestor"
  s.version     = InternetsRequestor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dev Team"]
  s.email       = ["digital.developers@simonandschuster.com"]
  s.homepage    = ""
  s.summary     = %q{To wrap up net http the way we like it.}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
