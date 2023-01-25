# frozen_string_literal: true

require "helper"

class TestSitemap < BridgetownSitemap::Test
  def prepare_site
    Bridgetown.reset_configuration!
    @config = Bridgetown.configuration(
      "full_rebuild"    => true,
      "root_dir"        => root_dir,
      "source"          => source_dir,
      "destination"     => dest_dir,
      "url"             => "https://example.com",
      "quiet"           => true
    )

    @config.run_initializers! context: :static
    @site = Bridgetown::Site.new(@config)
  end

  def process_site
    @site.process
  end

  describe "rendering the site with defaults" do
    before(:all) do
      prepare_site
      process_site

      @sitemap = File.read(dest_dir("sitemap.xml"))
      @robots = File.read(dest_dir("robots.txt"))
    end

    it "creates the sitemap without a layout" do
      assert File.exist?(dest_dir("sitemap.xml"))
      refute_match %r!THIS IS MY LAYOUT!, @sitemap
    end

    it "creates robots.txt without a layout" do
      assert File.exist?(dest_dir("robots.txt"))
      refute_match %r!\ATHIS IS MY LAYOUT!, @robots
    end

    it "puts all the pages in the sitemap" do
      assert_match %r!<loc>https://example\.com/</loc>!, @sitemap
      assert_match %r!<loc>https://example\.com/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
    end

    it "does not put files with output: false into the sitemap" do
      refute_match %r!/other_things/test2\.html</loc>!, @sitemap
    end

    it "performs URI encoding of site paths" do
      assert_match %r!<loc>https://example\.com/this%20url%20has%20an%20%C3%BCmlaut</loc>!, @sitemap
    end

    it "puts all the posts in the sitemap" do
      assert_match %r!<loc>https://example.com/2021/05/06/may-the-sixth/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/2021/03/04/march-the-fourth/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/2021/03/02/march-the-second/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/2019/07/14/last-modified-at/</loc>!, @sitemap
    end

    it "generates the correct date for each of the posts" do
      assert_match %r!<lastmod>2021-05-06T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap
      assert_match %r!<lastmod>2021-03-04T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap
      assert_match %r!<lastmod>2021-03-02T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap

      # This doesn't work on CI because it runs a git command which isn't allowed I guess
      unless ENV["GITHUB_ACTIONS"]
        assert_match %r!<lastmod>2019-07-14T18:22:00\+00:00</lastmod>!, @sitemap
      end
    end

    it "puts all the static HTML files in the sitemap.xml file" do
      assert_match %r!<loc>https://example\.com/some-subfolder/this-is-a-subfile\.html</loc>!, @sitemap
    end

    it "does not include assets or any static files that aren't .html" do
      refute_match %r!/assets/sample_image\.jpg</loc>!, @sitemap
      refute_match %r!/feeds/atom\.xml</loc>!, @sitemap
    end

    it "includes assets or any static files with .xhtml and .htm extensions" do
      assert_match %r!<loc>https://example\.com/some-subfolder/xhtml\.xhtml</loc>!, @sitemap
      assert_match %r!<loc>https://example\.com/some-subfolder/htm\.htm</loc>!, @sitemap
    end

    it "includes assets or any static files with .pdf extension" do
      assert_match %r!<loc>https://example\.com/assets/sample_pdf\.pdf</loc>!, @sitemap
    end

    it "does not include any files named 404.html" do
      refute_match %r!404.html!, @sitemap
    end

    it "does not include any static files that have set 'sitemap: false'" do
      refute_match %r!/excluded_files/excluded\.pdf!, @sitemap
    end

    it "does not include any static html files that have set 'sitemap: false'" do
      refute_match %r!/excluded_files/html_file\.html!, @sitemap
    end

    it "does not include posts that have set 'sitemap: false'" do
      refute_match %r!exclude-this-post!, @sitemap
    end

    it "does not include pages that have set 'sitemap: false'" do
      refute_match %r!exclude-this-page!, @sitemap
      refute_match %r!about!, @sitemap
    end

    it "correctly formats timestamps of static files" do
      assert_match %r!/this-is-a-subfile\.html</loc>\s+<lastmod>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(-|\+)\d{2}:\d{2}</lastmod>!, @sitemap
    end

    it "includes the correct number of items for the sitemap" do
      assert_equal 18, @sitemap.scan(%r!(?=<url>)!).count
    end

    it "includes generated pages in the sitemap" do
      assert_match %r!<loc>https://example.com/generated_page/</loc>!, @sitemap
    end

    it "renders liquid in the robots.txt" do
      assert_match "Sitemap: https://example.com/sitemap.xml", @robots
    end
  end

  describe "rendering the site with a base URL" do
    before(:all) do
      prepare_site
      @config.base_path = "/baseurl"
      process_site

      @sitemap = File.read(dest_dir("sitemap.xml"))
      @robots = File.read(dest_dir("robots.txt"))
    end

    it "adds the baseurl to the static files in the sitemap" do
      assert_match %r!<loc>https://example\.com/baseurl/some-subfolder/this-is-a-subfile\.html</loc>!, @sitemap
    end

    it "adds the baseurl to the pages in the sitemap" do
      assert_match %r!<loc>https://example\.com/baseurl/</loc>!, @sitemap
      assert_match %r!<loc>https://example\.com/baseurl/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
    end

    it "adds the baseurl to the posts in the sitemap" do
      assert_match %r!<loc>https://example.com/baseurl/2021/05/06/may-the-sixth/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/baseurl/2021/03/04/march-the-fourth/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/baseurl/2021/03/02/march-the-second/</loc>!, @sitemap
      assert_match %r!<loc>https://example.com/baseurl/2019/07/14/last-modified-at/</loc>!, @sitemap
    end

    it "adds the baseurl in the robots.txt" do
      assert_match "Sitemap: https://example.com/baseurl/sitemap.xml", @robots
    end
  end

  describe "rendering the site with a url that needs URI encoding" do
    before(:all) do
      prepare_site
      @config.url = "http://ümlaut.example.org"
      process_site

      @sitemap = File.read(dest_dir("sitemap.xml"))
    end

    it "performs URI encoding of site url" do
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/</loc>!, @sitemap
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/2021/03/04/march-the-fourth/</loc>!, @sitemap
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/2020/04/03/%E9%94%99%E8%AF%AF</loc>!, @sitemap
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/2020/04/02/%E9%94%99%E8%AF%AF</loc>!, @sitemap
      assert_match %r!<loc>http://xn--mlaut-jva.example.org/2019/04/01/%E9%94%99%E8%AF%AF/</loc>!, @sitemap
    end
  end

  describe "rendering the site with a user defined robots.txt" do
    before(:all) do
      prepare_site
      File.write(source_dir("robots.txt"), "ROBOT")
      process_site

      @robots = File.read(dest_dir("robots.txt"))
    end

    after(:all) do
      File.delete(source_dir("robots.txt"))
    end

    it "does not overwrite the robots.txt" do
      assert_match %r!ROBOT!, @robots
      refute_match %r!Sitemap!, @robots
    end
  end

  describe "rendering the site with an uncommitted file" do
    before(:all) do
      prepare_site
      File.write(source_dir("new.html"), "---\n---")
      process_site

      @sitemap = File.read(dest_dir("sitemap.xml"))
    end

    after(:all) do
      File.delete(source_dir("new.html"))
    end

    it "includes the uncommitted file in the sitemap" do
      assert_match %r!<loc>https://example.com/new/</loc>!, @sitemap
    end
  end
end

