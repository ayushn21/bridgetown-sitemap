# frozen_string_literal: true

module Bridgetown
  module Resource
    class Base
      def sitemap_last_modified_at
        (
          data.last_modified_at ||
          BridgetownSitemap::GitInspector.new(self).latest_git_commit_date ||
          date
        )&.to_time
      end
    end
  end
end
