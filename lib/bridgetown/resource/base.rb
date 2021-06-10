# frozen_string_literal: true

module Bridgetown
  module Resource
    class Base
      def sitemap_last_modified_at
        data.last_modified_at || latest_git_commit_date || date
      end

      private

      def latest_git_commit_date
        date = `git log -1 --pretty="format:%cI" "#{path}"`
        Time.parse(date) if date.present?
      end
    end
  end
end
