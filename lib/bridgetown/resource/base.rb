module Bridgetown
  module Resource
    class Base
      def sitemap_last_modified_at
        self.data.last_modified_at || File.mtime(path) || date
      end
    end
  end
end