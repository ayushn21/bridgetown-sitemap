# frozen_string_literal: true

module BridgetownSitemap
  class GroupedResources
    def initialize(resources)
      @grouped_resources = resources.group_by do |resource|
         [resource.data.slug, resource.date]
      end.values
    end

    def each(locale:, &block)
      @grouped_resources.each do |resource_group|
        resource_group = resource_group.reject do |resource|
          resource.id == "/404" || resource.data.sitemap == false
        end

        default_resource = resource_group.detect do |resource|
          !resource.data.locale || locale == resource.data.locale
        end

        latest_resource = resource_group.max_by { |resource| resource.data.sitemap_last_modified_at }

        yield default: default_resource, latest: latest_resource, group: resource_group
      end
    end
  end
end