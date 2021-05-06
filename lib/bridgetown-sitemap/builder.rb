# frozen_string_literal: true

require "fileutils"
require "byebug"

module BridgetownSitemap
  class Builder < Bridgetown::Builder
    def build
      hook :site, :pre_render, priority: :low do |site|
        # TODO: Throw exception if the new resource engine isn't being used
        @site = site

        @site.generated_pages << sitemap unless file_exists?("sitemap.xml")
        @site.generated_pages << robots unless file_exists?("robots.txt")
      end
    end

    private

    INCLUDED_EXTENSIONS = %w(
      .htm
      .html
      .xhtml
      .pdf
      .xml
    ).freeze

    # Array of all non-bridgetown site files with an HTML extension
    def static_files
      @site.static_files.select { |file| INCLUDED_EXTENSIONS.include? file.extname }
    end

    def source_path(file)
      File.expand_path "../#{file}", __dir__
    end

    def destination_path(file)
      @site.in_dest_dir(file)
    end

    def sitemap
      site_map = Bridgetown::GeneratedPage.new(@site, @site.source, "/", "sitemap.erb", from_plugin: true)
      site_map.content = File.read(source_path(site_map.name))
      site_map.data.permalink = "/sitemap.xml"
      site_map.data.layout = "none"
      site_map.data.static_files = static_files
      site_map.data.xsl = file_exists?("sitemap.xsl")
      site_map
    end

    def robots
      robots = Bridgetown::GeneratedPage.new(@site, @site.source, "/", "robots.liquid", from_plugin: true)
      robots.content = File.read(source_path(robots.name))
      robots.data.layout = "none"
      robots.data.permalink = "/robots.txt"
      robots
    end

    # Checks if a file already exists in the site source
    def file_exists?(file_path)
      pages_and_files.any? { |p| p.relative_path == "/#{file_path}" }
    end

    def pages_and_files
      @pages_and_files ||= @site.collections.pages.resources + @site.static_files
    end
  end
end
