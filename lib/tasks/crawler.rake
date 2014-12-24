require 'crawler'

desc 'Crawling mine craft servers, options START=1 start server id, STOP=300 stopped server id'
task :crawler => :environment do
  start = ENV.fetch('START', 1).to_i 
  stop = ENV.fetch('STOP', 300).to_i
  interval = ENV.fetch('INTERVAL', 5 * 60).to_i
  puts "Start from #{start} to #{stop} with interval #{interval} seconds"
  Crawler.call(start, stop, interval)
end
