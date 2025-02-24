# frozen_string_literal: true

require_relative "lib/bridgetown-sitemap/version"

Gem::Specification.new do |spec|
  spec.name        = "bridgetown-sitemap"
  spec.summary     = "Automatically generate a sitemap.xml for your Bridgetown site."
  spec.version     = BridgetownSitemap::VERSION
  spec.authors     = ["Ayush Newatia"]
  spec.email       = "ayush@hey.com"
  spec.homepage    = "https://github.com/ayushn21/bridgetown-sitemap"
  spec.licenses    = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r!^bin/!) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r!^(test|spec|features)/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.2.4"

  spec.add_dependency "bridgetown", ">= 1.3.0", "< 3.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop-bridgetown"
end
