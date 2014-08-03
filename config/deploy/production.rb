# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"

role :web, "www.recommendationengine.co"
role :app, "www.recommendationengine.co"
role :db, "www.recommendationengine.co", :primary => true

disable_path = "/var/www/lottery_picker/current/public"

# update the cron job
set :whenever_roles, [:app]
set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }

require "whenever/capistrano"

namespace :deploy do
  desc "Copy resque-web assets into public folder"
  task :copy_resque_assets do
    target = File.join(release_path,'public','resque')
    run "cp -r `cd #{release_path} && bundle show resque`/lib/resque/server/public #{target}"
  end
end

after "deploy:update_code", "deploy:migrate"

after "deploy:restart", "deploy:copy_resque_assets"

# resque_workers hooks
namespace :resque_workers do
  [:start, :stop, :restart].each do |t|
    task t, :roles => [:app] do
      sudo "monit -g resque_workers #{t}"
    end
  end
end

namespace :deploy do
  desc "Copy resque-web assets into public folder"
  task :copy_resque_assets do
    target = File.join(release_path,'public','resque')
    run "cp -r `cd #{release_path} && bundle show resque`/lib/resque/server/public #{target}"
  end
end