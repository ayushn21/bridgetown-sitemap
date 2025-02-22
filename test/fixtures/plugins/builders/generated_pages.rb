class Builders::GeneratedPages < SiteBuilder
  def build
    generator do
      generated_page = Bridgetown::GeneratedPage.new(site, site.source, "/", "generated_page.erb")
      generated_page.content = "<%= 'created from a plugin'.capitalize %>"
      generated_page.data.layout = "default"

      generated_page_ru = Bridgetown::GeneratedPage.new(site, site.source, "/ru", "generated_page.erb")
      generated_page_ru.content = "<%= '(RU) created from a plugin'.capitalize %>"
      generated_page_ru.data.layout = "default"
      generated_page_ru.data.locale = :ru

      site.generated_pages << generated_page
      site.generated_pages << generated_page_ru
    end
  end
end
