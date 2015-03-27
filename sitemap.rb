require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://minecraftservers-ip.com'
SitemapGenerator::Sitemap.create do
  add '/contacts', :changefreq => 'daily', :priority => 0.9
end