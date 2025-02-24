# frozen_string_literal: true

require "bridgetown"
require "bridgetown-sitemap/builder"
require "bridgetown-sitemap/git_inspector"
require "bridgetown-sitemap/grouped_resources"
require "bridgetown-sitemap/grouped_generated_pages"
require "bridgetown/resource/base"

Bridgetown.initializer :"bridgetown-sitemap" do |config|
  config.builder BridgetownSitemap::Builder
end
