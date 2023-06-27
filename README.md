# Bridgetown Sitemap Generator Plugin

[![Tests](https://github.com/ayushn21/bridgetown-sitemap/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/ayushn21/bridgetown-sitemap/actions/workflows/tests.yml)
[![Gem Version](https://badge.fury.io/rb/bridgetown-sitemap.svg)](https://badge.fury.io/rb/bridgetown-sitemap)

Bridgetown plugin to silently generate a sitemaps.org compliant sitemap for your Bridgetown site

## Usage

1. Install the plugin with the following command:

```shell
bundle add bridgetown-sitemap
```

2. Add the following to your site's `config/initializers.rb`:

```ruby
Bridgetown.configure do |config|
  config.url = "https://example.com" # the base hostname & protocol for your site

  init :"bridgetown-sitemap"
end
```

## `<lastmod>` tag
The `<lastmod>` tag in the `sitemap.xml` will reflect by priority:

1. A personalised date if you add the variable `last_modified_at:` with a date in the Front Matter. (*Dates need to be formatted as* `%Y-%m-%d %H:%M:%S %z`)
2. The modified date of the file as reported by `git log`.


## `<priority>` and `<changefreq>` tag
You can optionally specify a _priority_ and _change frequency_ for each page in your site by adding the following to the Front Matter of each page:

```yml
sitemap_priority: 0.7
sitemap_change_frequency: weekly
```

This will add the following to the `<url>` tag in the `sitemap.xml`:

```xml
<priority>0.7</priority>
<changefreq>weekly</changefreq>
```


## Exclusions

If you would like to exclude specific pages from the sitemap set the
sitemap flag to `false` in the front matter for the page.

```yml
sitemap: false
```

To exclude multiple files, add a glob config to your `config/initializers.rb` file.

```ruby
Bridgetown.configure do |config|
  # ...

  config.defaults << {
    "scope" => { "path" => "assets/**/*.pdf" },
    "values" => { "sitemap" => false }
  }
end
```

## Testing

* Run `bundle exec rake test` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and run tests together.

## Contributing

1. Fork it (https://github.com/ayushn21/bridgetown-sitemap/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## License

Bridgetown Sitemap is released under the [MIT License](https://opensource.org/licenses/MIT).

Copyright © 2023 [Ayush Newatia](https://twitter.com/ayushn21)