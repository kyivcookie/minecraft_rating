# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'planandride'
set :repo_url, 'ssh://git@bitbucket.org/tranc3/planandride-backend.git'
set :deploy_to, '/home/planandride/webapps/planandride'
set :tmp_dir, '/home/planandride/tmp'

set :pty, true

set :linked_dirs, fetch(:linked_dirs, []).push('public')

set :default_env, {
                    path: "#{deploy_to}/bin:$PATH",
                    gem_home: "#{deploy_to}/gems",
                    rubylib: "#{deploy_to}/lib"
                }

set :keep_releases, 3

role :web, 'web433.webfaction.com'
role :app, 'web433.webfaction.com'
role :db,  'web433.webfaction.com', :primary => true

desc 'Restart nginx'
task :restart do
  on roles(:app) do
    execute "#{deploy_to}/bin/restart"
  end
end

desc 'Start nginx'
task :start do
  on roles(:app) do
    execute "#{deploy_to}/bin/start"
  end
end

desc 'Stop nginx'
task :stop do
  on roles(:app) do
    execute "#{deploy_to}/bin/stop"
  end
end

namespace :deploy do

  puts '='*80
  puts "\n"
  puts '         (  )   (   )  )'
  puts '      ) (   )  (  (         GO GRAB SOME COFFEE'
  puts '      ( )  (    ) )'
  puts '     <_____________> ___    CAPISTRANO IS ROCKING!'
  puts '     |             |/ _ \\'
  puts '     |               | | |'
  puts '     |               |_| |'
  puts '  ___|             |\\___/'
  puts ' /    \\___________/    \\'
  puts ' \\_____________________/ '
  puts '='*80

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  desc 'Remake database'
  task :remakedb do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{deploy_to}/current;  ;bundle exec rake db:migrate RAILS_ENV=production"
    end
  end

  desc 'Seed database'
  task :seed do
    on roles(:app), in: :sequence, wait: 5 do
      # execute "cd #{deploy_to}/current; bundle exec rake db:seed RAILS_ENV=#{default_stage}"
    end
  end

  desc 'Migrate database'
  task :migrate do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{deploy_to}/current && RAILS_ENV=production PATH=/home/planandride/webapps/planandride/bin:$PATH GEM_HOME=/home/planandride/webapps/planandride/gems RUBYLIB=/home/planandride/webapps/planandride/lib bundle exec rake db:migrate"
    end
  end

  desc 'Bundle install gems'
  task :bundle do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{deploy_to}/current && RAILS_ENV=production GEM_HOME=/home/planandride/webapps/planandride/gems PATH=/home/planandride/webapps/planandride/bin:/usr/local/bin:$PATH bundle install --no-deployment"
    end
  end

  task :link_production_db do
    on roles(:app), in: :sequence, wait: 5 do
      execute "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    end
  end

  namespace :assets do
    desc 'Run the precompile task remotely'
    task :precompile do
      on roles(:app), in: :sequence, wait: 5 do
        execute "cd #{deploy_to}/current && RAILS_ENV=production GEM_HOME=/home/planandride/webapps/planandride/gems PATH=/home/planandride/webapps/planandride/bin:/usr/local/bin:$PATH bundle exec rake assets:precompile"
      end
    end
  end
end

after 'deploy', 'deploy:bundle'
# after 'deploy', 'deploy:assets:precompile'
after 'deploy', 'deploy:link_production_db'
after 'deploy', 'deploy:migrate'
# after 'deploy', 'deploy:cleanup'
after 'deploy', 'restart'
