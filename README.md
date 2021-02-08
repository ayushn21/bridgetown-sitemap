# Bridgetown Sitemap Generator Plugin

*Bridgetown plugin to silently generate a sitemaps.org compliant sitemap for your Bridgetown site*

## Usage

1. Install the plugin with the following command:

```shell
bundle add bridgetown-sitemap -g bridgetown_plugins
```

2. Add the following to your site's `bridgetown.config.yml`:

```yml
url: "https://example.com" # the base hostname & protocol for your site
```

If you have other plugins which generate content and store that content in `site.pages`, `site.posts`, or `site.collections`, be sure to require `bridgetown-sitemap` either *after* those other gems if you *want* the sitemap to include the generated content, or *before* those other gems if you *don't want* the sitemap to include the generated content from the gems. (Programming is *hard*.)

Because the sitemap is added to `site.pages`, you may have to modify any
templates that iterate through all pages (for example, to build a menu of
all of the site's content).

## `<lastmod>` tag
The `<lastmod>` tag in the `sitemap.xml` will reflect by priority:

1.   The modified date of the file as reported by the filesystem if you have `jekyll-last-modified-at` plugin installed
2.   A personalised date if you add the variable `last_modified_at:` with a date in the Front Matter
3.   The creation date of your post (corresponding to the `post.date` variable)

## Exclusions

If you would like to exclude specific pages/posts from the sitemap set the
sitemap flag to `false` in the front matter for the page/post.

```yml
sitemap: false
```

To exclude files from your sitemap. It can be achieved with configuration using [Jekyll v3.7.2 and jekyll-sitemap v1.2.0](https://github.com/jekyll/jekyll/commit/776433109b96cb644938ffbf9caf4923bdde4d7f).

Add a glob config to your `_config.yml` file.

```yml
defaults:
  -
    scope:
      path:            "assets/**/*.pdf"
    values:
      sitemap:         false
```

## Override default development settings

[Follow these instructions on Jekyll's documentation](https://jekyllrb.com/docs/usage/#override-default-development-settings).

## Known Issues

1. If the `sitemap.xml` doesn't generate in the `_site` folder, ensure `_config.yml` doesn't have `safe: true`. That prevents all plugins from working.
2. If the `sitemap.xml` doesn't generate in the `_site` folder, ensure that you don't have a sitemap generator plugin in your `_plugin` folder.

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