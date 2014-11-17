# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require_relative 'app/models/ping/serversping'
require_relative 'app/helpers/servers_helper'

namespace :mc do
  task :servers do
    McStatus::ServerUpdater.new(Serversping.all).update!
  end
end

Rails.application.load_tasks
