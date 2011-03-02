# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hoptoad_zmq_notifier/version"

Gem::Specification.new do |s|
  s.name        = "hoptoad_zmq_notifier"
  s.version     = HoptoadZmqNotifier::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nick Recobra"]
  s.email       = ["oruenu@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "hoptoad_notifier_zmq"

  s.add_dependency 'hoptoad_notifier', '> 0'
  s.add_dependency 'ffi-rzmq'
  s.add_dependency 'ffi'
  s.add_development_dependency 'rspec', '>= 2.5.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
