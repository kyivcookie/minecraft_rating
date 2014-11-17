# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require_relative 'app/models/ping/servers_ping'
require_relative 'app/helpers/servers_helper'
require_relative 'app/uploaders/banner_uploader'


namespace :mc do
  task :servers do
    McStatus::ServerUpdater.new(ServersPing.all).update!
  end
end

Rails.application.load_tasks
