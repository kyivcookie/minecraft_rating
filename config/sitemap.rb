SitemapGenerator::Sitemap.default_host = "http://minecraftservers-ip.com"
SitemapGenerator::Sitemap.create do
  add '/contact'
  add '/articles/1'
  add '/articles/2'
  add '/articles/3'
  add '/articles/4'
  Server.find_each do |srv|
    add server_path(srv), :lastmod => srv.updated_at, :changefreq => 'daily'
  end
end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

