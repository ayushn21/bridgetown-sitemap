# frozen_string_literal: true

require "bridgetown"
require "bridgetown-sitemap/builder"
require "bridgetown-sitemap/git_inspector"
require "bridgetown/resource/base"

Bridgetown.initializer :"bridgetown-sitemap" do |config|
  config.builder BridgetownSitemap::Builder
end
