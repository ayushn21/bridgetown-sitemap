class Builders::GeneratedPages < SiteBuilder
  def build
    generator do
      generated_page = Bridgetown::GeneratedPage.new(site, site.source, "/", "generated_page.erb")
      generated_page.content = "<%= 'created from a plugin'.capitalize %>"
      generated_page.data.layout = "default"

      site.generated_pages << generated_page
    end
  end
end