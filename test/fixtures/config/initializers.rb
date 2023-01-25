# frozen_string_literal: true

Bridgetown.configure do |config|
  timezone "UTC"

  config.defaults << {
    "scope" => { "path" => "excluded_files/**/*" },
    "values" => { "sitemap" => false }
  }

  init :"bridgetown-sitemap"
end