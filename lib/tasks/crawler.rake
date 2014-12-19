require 'crawler'

desc 'Crawling mine craft servers, options START=1 start server id, STOP=300 stopped server id'
task :crawler => :environment do
  start = (ENV['START'] || 1).to_i
  stop = (ENV['STOP'] || 300).to_i
  puts "Start from #{start} to #{stop}"
  Crawler.call(start, stop)
end
