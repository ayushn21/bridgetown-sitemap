# frozen_string_literal: true

module BridgetownSitemap
  class GitInspector
    def initialize(resource)
      @resource = resource
    end

    def latest_git_commit_date
      return nil unless git_repo?
      return nil unless repo_origin?

      date = cache.getset(@resource.id) do
        `git log -1 --pretty="format:%cI" "#{@resource.path}"`
      end

      Time.parse(date) if date.present?
    end

    private

      def repo_origin?
        @resource.model.origin.url.scheme == "repo"
      end

      def git_repo?
        system "git status", out: File::NULL, err: File::NULL
      end

      def cache
        @cache ||= Bridgetown::Cache.new("sitemap")
      end
  end
end
