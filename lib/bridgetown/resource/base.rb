# frozen_string_literal: true

module Bridgetown
  module Resource
    class Base
      def sitemap_last_modified_at
        data.last_modified_at || File.mtime(path) || date
      end
    end
  end
end
