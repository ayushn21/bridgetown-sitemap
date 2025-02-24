# frozen_string_literal: true

Bridgetown.configure do |config|
  timezone "UTC"

  config.defaults << {
    "scope" => { "path" => "excluded_files/**/*" },
    "values" => { "sitemap" => false }
  }

  available_locales [ :en, :ru ]
  default_locale :en

  init :"bridgetown-sitemap"
end
