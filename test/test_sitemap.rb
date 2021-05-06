# frozen_string_literal: true

require "helper"

class TestSitemap < BridgetownSitemap::Test

  context "rendering the site with defaults" do
    setup { build_site }

    should "create the sitemap" do
      assert File.exist?(dest_dir("sitemap.xml"))
    end

    should "create robots.txt" do
      assert File.exist?(dest_dir("robots.txt"))
    end

    context "the sitemap" do
      setup { @sitemap = File.read(dest_dir("sitemap.xml")) }

      should "have no layout" do
        refute_match %r!THIS IS MY LAYOUT!, @sitemap
      end

      should "put all the pages in the sitemap" do
        assert_match %r!<loc>https://example\.com/</loc>!, @sitemap
        assert_match %r!<loc>https://example\.com/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
      end

      should "not put files with output: false into the sitemap" do
        refute_match %r!/other_things/test2\.html</loc>!, @sitemap
      end

      should "performs URI encoding of site paths" do
        assert_match %r!<loc>https://example\.com/this%20url%20has%20an%20%C3%BCmlaut</loc>!, @sitemap
      end

      should "put all the posts in the sitemap" do
        assert_match %r!<loc>https://example.com/2021/05/06/may-the-sixth/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/2021/03/04/march-the-fourth/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/2021/03/02/march-the-second/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/2019/07/14/last-modified-at/</loc>!, @sitemap
      end

      should "generate the correct date for each of the posts" do
        assert_match %r!<lastmod>2021-05-06T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap
        assert_match %r!<lastmod>2021-03-04T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap
        assert_match %r!<lastmod>2021-03-02T00:00:00(-|\+)\d+:\d+</lastmod>!, @sitemap
        assert_match %r!<lastmod>2020-12-24T03:51:50\+00:00</lastmod>!, @sitemap
      end

      should "puts all the static HTML files in the sitemap.xml file" do
        assert_match %r!<loc>https://example\.com/some-subfolder/this-is-a-subfile\.html</loc>!, @sitemap
      end

      should "does not include assets or any static files that aren't .html" do
        refute_match %r!/assets/sample_image\.jpg</loc>!, @sitemap
        refute_match %r!/feeds/atom\.xml</loc>!, @sitemap
      end

      should "include assets or any static files with .xhtml and .htm extensions" do
        assert_match %r!<loc>https://example\.com/some-subfolder/xhtml\.xhtml</loc>!, @sitemap
        assert_match %r!<loc>https://example\.com/some-subfolder/htm\.htm</loc>!, @sitemap
      end

      should "include assets or any static files with .pdf extension" do
        assert_match %r!<loc>https://example\.com/assets/sample_pdf\.pdf</loc>!, @sitemap
      end

      should "not include any files named 404.html" do
        refute_match %r!404.html!, @sitemap
      end

      should "not include any static files that have set 'sitemap: false'" do
        refute_match %r!/excluded_files/excluded\.pdf!, @sitemap
      end

      should "not include any static html files that have set 'sitemap: false'" do
        refute_match %r!/excluded_files/html_file\.html!, @sitemap
      end

      should "not include posts that have set 'sitemap: false'" do
        refute_match %r!exclude-this-post!, @sitemap
      end

      should "not include pages that have set 'sitemap: false'" do
        refute_match %r!exclude-this-page!, @sitemap
        refute_match %r!about!, @sitemap
      end

      should "correctly format timestamps of static files" do
        assert_match %r!/this-is-a-subfile\.html</loc>\s+<lastmod>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(-|\+)\d{2}:\d{2}</lastmod>!, @sitemap
      end

      should "include the correct number of items" do
        assert_equal 16, @sitemap.scan(%r!(?=<url>)!).count
      end

      should "include generated pages" do
      end
    end

    context "the robots.txt" do
      setup { @robots = File.read(dest_dir("robots.txt")) }

      should "have no layout" do
        refute_match %r!\ATHIS IS MY LAYOUT!, @robots
      end

      should "renders liquid" do
        assert_match "Sitemap: https://example.com/sitemap.xml", @robots
      end
    end
  end

  context "rendering the site with a baseurl" do
    setup do
      config.baseurl = "/baseurl"
      build_site
    end

    context "the sitemap" do
      setup { @sitemap = File.read(dest_dir("sitemap.xml")) }

      should "add the baseurl to the static files" do
        assert_match %r!<loc>https://example\.com/baseurl/some-subfolder/this-is-a-subfile\.html</loc>!, @sitemap
      end

      should "add the baseurl to the pages" do
        assert_match %r!<loc>https://example\.com/baseurl/</loc>!, @sitemap
        assert_match %r!<loc>https://example\.com/baseurl/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
      end

      should "add the baseurl to the posts" do
        assert_match %r!<loc>https://example.com/baseurl/2021/05/06/may-the-sixth/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/baseurl/2021/03/04/march-the-fourth/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/baseurl/2021/03/02/march-the-second/</loc>!, @sitemap
        assert_match %r!<loc>https://example.com/baseurl/2019/07/14/last-modified-at/</loc>!, @sitemap
      end
    end

    context "the robots.txt" do
      setup { @robots = File.read(dest_dir("robots.txt")) }

      should "add contain the baseurl" do
        assert_match "Sitemap: https://example.com/baseurl/sitemap.xml", @robots
      end
    end
  end

  context "rendering the site with a url that needs URI encoding" do
    setup do
      config.url = "http://ümlaut.example.org"
      build_site
    end

    context "the sitemap" do
      setup { @sitemap = File.read(dest_dir("sitemap.xml")) }

      should "performs URI encoding of site url" do
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/</loc>!, @sitemap
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/some-subfolder/this-is-a-subpage/</loc>!, @sitemap
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/2021/03/04/march-the-fourth/</loc>!, @sitemap
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/2020/04/03/%E9%94%99%E8%AF%AF</loc>!, @sitemap
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/2020/04/02/%E9%94%99%E8%AF%AF</loc>!, @sitemap
        assert_match %r!<loc>http://xn--mlaut-jva.example.org/2019/04/01/%E9%94%99%E8%AF%AF/</loc>!, @sitemap
      end
    end
  end

  context "rendering the site with a user defined robots.txt" do
    setup do
      File.write(source_dir("robots.txt"), "ROBOT")
      build_site
      @robots = File.read(dest_dir("robots.txt"))
    end

    teardown do
      File.delete(source_dir("robots.txt"))
    end

    should "not overwrite the robots.txt" do
      assert_match %r!ROBOT!, @robots
      refute_match %r!Sitemap!, @robots
    end
  end

  context "rendering the site without the resource content engine" do
    should "throw an error" do
    end
  end
end
