# main

# 3.0.1 / 24-12-2025

* Remove uses of `.present?`

# 3.0.0 / 24-02-2025

* Add i18n support
* Drop support for Bridgetown 1.2.x and lower
* Drop support for Ruby 3.1.x and lower
* Fix git error for dynamically generated resources

# 2.0.2 / 27-06-2023

* Add support for priority and changefreq tags.

# 2.0.1 / 04-04-2023

* Cache `git log` value for last modified date.

# 2.0.0 / 25-01-2023

* Restrict support to Bridgetown v1.2 and newer.
* Initialize plugin using the new Ruby DSL in Bridgetown v1.2.

# 1.2.0 / 23-01-2023

* Require Bridgetown 1.0 or newer.
* Require Ruby 2.7 or newer.

# 1.1.2 / 18-02-2022

* Handle cases where the site is not in a git repo
* Fix an error when the resource has a modified date but not a time

# 1.1.1 / 11-06-2021

* Fix an error when building a site with uncommitted files.

# 1.1.0 / 07-05-2021

* Change `<lastmod>` behaviour to use time from `git log` rather than from the filesystem.

# 1.0.0 / 06-05-2021

* Initial release
