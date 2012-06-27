# -*- encoding: utf-8 -*-
require File.expand_path('../lib/canonical_domain/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Blake Thomson"]
  gem.email         = ["thomsbg@gmail.com"]
  gem.description   = %q{Stores a 'canonical domain' in the rack environment for stability across different environments}
  gem.summary       = %q{Rack middleware that manipulates the request host according to config, and stores it in the rack environment at 'canonical_domain.domain'. See https://github.com/thomsbg/canonical_domain for a use case.}
  gem.homepage      = "https://github.com/thomsbg/canonical_domain"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "canonical_domain"
  gem.require_paths = ["lib"]
  gem.version       = CanonicalDomain::VERSION
end
