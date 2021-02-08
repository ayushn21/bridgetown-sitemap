# frozen_string_literal: true

require "fileutils"

module BridgetownSitemap
  class Builder < Bridgetown::Builder
    def build
      hook :site, :post_render, priority: :low do |site|
        @site = site
        @site.pages << sitemap unless file_exists?("sitemap.xml")
        @site.pages << robots unless file_exists?("robots.txt")
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

    def source_path
      File.expand_path "../", __dir__
    end

    def destination_path(file = "sitemap.xml")
      @site.in_dest_dir(file)
    end

    def sitemap
      site_map = Bridgetown::Page.new(@site, @site.source, "/", "sitemap.xml")
      site_map.read_yaml(source_path, "sitemap.xml")
      site_map.data["layout"] = nil
      site_map.data["static_files"] = static_files.map(&:to_liquid)
      site_map
    end

    def robots
      robots = Bridgetown::Page.new(@site, @site.source, "/", "robots.txt")
      robots.read_yaml(source_path, "robots.txt")
      robots.data["layout"] = nil
      robots
    end

    # Checks if a file already exists in the site source
    def file_exists?(file_path)
      pages_and_files.any? { |p| p.url == "/#{file_path}" }
    end

    def pages_and_files
      @pages_and_files ||= @site.pages + @site.static_files
    end
  end
end
