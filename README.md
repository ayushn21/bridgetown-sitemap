# Bridgetown Sitemap Generator Plugin

**_Bridgetown plugin to silently generate a sitemaps.org compliant sitemap for your Bridgetown site_**

## Usage

1. Install the plugin with the following command:

```shell
bundle add bridgetown-sitemap -g bridgetown_plugins
```

2. Add the following to your site's `bridgetown.config.yml`:

```yml
url: "https://example.com" # the base hostname & protocol for your site
```

<br>

**This plugin only supports Bridgetown sites that use the [resource content engine](https://www.bridgetownrb.com/docs/resources).**

This can be configured by adding the following line to your site's `bridgetown.config.yml`:

```yml
content_engine: "resource"
```


## `<lastmod>` tag
The `<lastmod>` tag in the `sitemap.xml` will reflect by priority:

1. A personalised date if you add the variable `last_modified_at:` with a date in the Front Matter. (*Dates need to be formatted as* `%Y-%m-%d %H:%M:%S %z`)
2. The modified date of the file as reported by the `git log`.


## Exclusions

If you would like to exclude specific pages from the sitemap set the
sitemap flag to `false` in the front matter for the page.

```yml
sitemap: false
```

To exclude multiple files, add a glob config to your `bridgetown.config.yml` file.

```yml
defaults:
  -
    scope:
      path: "assets/**/*.pdf"
    values:
      sitemap: false
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