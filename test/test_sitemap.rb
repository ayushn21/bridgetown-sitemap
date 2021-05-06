# frozen_string_literal: true

require "helper"

class TestSitemap < BridgetownContentSecurityPolicy::Test

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
        assert_not @sitemap.match %r!THIS IS MY LAYOUT!
      end

      should "put all the pages in the sitemap" do
      end

      should "not put files with output: false into the sitemap" do
      end

      should "performs URI encoding of site paths" do
        # expect(contents).to match %r!<loc>http://example\.org/this%20url%20has%20an%20%C3%BCmlaut</loc>!
      end

      should "put all the posts in the sitemap" do
      end

      should "generate the correct date for each of the posts" do
      end

      should "puts all the static HTML files in the sitemap.xml file" do
        # expect(contents).to match %r!<loc>http://example\.org/some-subfolder/this-is-a-subfile\.html</loc>!
      end

      should "does not include assets or any static files that aren't .html" do
        # expect(contents).not_to match %r!<loc>http://example\.org/images/hubot\.png</loc>!
        # expect(contents).not_to match %r!<loc>http://example\.org/feeds/atom\.xml</loc>!
      end

      should "include assets or any static files with .xhtml and .htm extensions" do
        # expect(contents).to match %r!/some-subfolder/xhtml\.xhtml!
        # expect(contents).to match %r!/some-subfolder/htm\.htm!
      end

      should "include assets or any static files with .pdf extension" do
        # expect(contents).to match %r!/static_files/test.pdf!
      end

      should "include assets or any static files with .xml extension" do
        # expect(contents).to match %r!/static_files/test.xml!
      end

      should "not include any files named 404.html" do
        # expect(contents).not_to match %r!404.html!
      end

      should "not include any static files that have set 'sitemap: false'" do
        # expect(contents).not_to match %r!/static_files/excluded\.pdf!
      end

      should "not include any static html files that have set 'sitemap: false'" do
        # expect(contents).not_to match %r!/static_files/html_file\.html!
      end

      should "not include posts that have set 'sitemap: false'" do
        # expect(contents).not_to match %r!/exclude-this-post\.html</loc>!
      end

      should "not include pages that have set 'sitemap: false'" do
        # expect(contents).not_to match %r!/exclude-this-page\.html</loc>!
      end

      should "correctly format timestamps of static files" do
        # expect(contents).to match %r!/this-is-a-subfile\.html</loc>\s+<lastmod>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(-|\+)\d{2}:\d{2}</lastmod>!
      end

      should "include the correct number of items" do
        # expect(contents.scan(%r!(?=<url>)!).count).to eql 22
      end
    end

    context "the robots.txt" do
#       it "has no layout" do
#         expect(contents).not_to match(%r!\ATHIS IS MY LAYOUT!)
#       end

#       it "renders liquid" do
#         expect(contents).to match("Sitemap: http://xn--mlaut-jva.example.org/sitemap.xml")
#       end
    end

  end

  context "rendering the site with a baseurl" do
#     it "correctly adds the baseurl to the static files" do
#       expect(contents).to match %r!<loc>http://example\.org/bass/some-subfolder/this-is-a-subfile\.html</loc>!
#     end

#     it "correctly adds the baseurl to the collections" do
#       expect(contents).to match %r!<loc>http://example\.org/bass/my_collection/test\.html</loc>!
#     end

#     it "correctly adds the baseurl to the pages" do
#       expect(contents).to match %r!<loc>http://example\.org/bass/</loc>!
#       expect(contents).to match %r!<loc>http://example\.org/bass/some-subfolder/this-is-a-subpage\.html</loc>!
#     end

#     it "correctly adds the baseurl to the posts" do
#       expect(contents).to match %r!<loc>http://example\.org/bass/2014/03/04/march-the-fourth\.html</loc>!
#       expect(contents).to match %r!<loc>http://example\.org/bass/2014/03/02/march-the-second\.html</loc>!
#       expect(contents).to match %r!<loc>http://example\.org/bass/2013/12/12/dec-the-second\.html</loc>!
#     end

#     it "adds baseurl to robots.txt" do
#       content = File.read(dest_dir("robots.txt"))
#       expect(content).to match("Sitemap: http://example.org/bass/sitemap.xml")
#     end
  end

  context "rendering the site with a url that needs URI encoding" do
#     let(:config) do
#       Jekyll.configuration(Jekyll::Utils.deep_merge_hashes(overrides, "url" => "http://ümlaut.example.org"))
#     end

#     it "performs URI encoding of site url" do
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/</loc>!
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/some-subfolder/this-is-a-subpage.html</loc>!
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/2014/03/04/march-the-fourth.html</loc>!
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/2016/04/01/%E9%94%99%E8%AF%AF.html</loc>!
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/2016/04/02/%E9%94%99%E8%AF%AF.html</loc>!
#       expect(contents).to match %r!<loc>http://xn--mlaut-jva.example.org/2016/04/03/%E9%94%99%E8%AF%AF.html</loc>!
#     end

#     it "does not double-escape urls" do
#       expect(contents).to_not match %r!%25!
#     end
  end

  context "rendering the site with a user defined robots.txt" do
    should "not overwrite the robots.txt" do
    end
  end

  context "rendering the site without the resource content engine" do
    should "throw an error" do
    end
  end
end
