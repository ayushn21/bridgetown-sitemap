# frozen_string_literal: true

module BridgetownSitemap
  class GroupedGeneratedPages
    def initialize(generated_pages)
      @grouped_generated_pages = \
        generated_pages.group_by { |page| page.data.slug }.values
    end

    def each(locale:, &block)
      @grouped_generated_pages.each do |page_group|
        page_group = page_group.reject do |page|
          ["sitemap.erb", "robots.liquid"].include?(page.name) ||
            page.data.sitemap == false
        end

        default_page = page_group.detect do |page|
          !page.data.locale || locale == page.data.locale
        end

        latest_page = page_group.max_by { |page| page.data.last_modified_at }

        yield default: default_page, latest: latest_page, group: page_group
      end
    end
  end
end