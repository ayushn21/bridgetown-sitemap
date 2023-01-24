# frozen_string_literal: true

require "bridgetown"
require "bridgetown/resource/base"
require "bridgetown-sitemap/builder"

Bridgetown.initializer :"bridgetown-sitemap" do |config|
  config.builder BridgetownSitemap::Builder
end
