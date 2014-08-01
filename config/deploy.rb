require 'capistrano/ext/multistage'
require 'rvm/capistrano'

set :rvm_bin_path, "/usr/local/rvm/bin"
set :rvm_ruby_string, "2.1.2"
set :rvm_type, :root
set :use_sudo, false


require 'bundler/capistrano'
set :bundle_cmd, "bundle"

set :bundle_without, [:darwin, :development, :test]

set :keep_releases, 5
after "deploy", "deploy:cleanup"

set :application, 'hiyou_server'
set :repository, "ssh://git@bitbucket.org/daifu/lottery_picker.git"
set :deploy_via, :remote_cache

set :branch, 'master'

set :scm, :git
set :use_sudo, false

set :user, "build"
set :runner, "build"
set :ssh_options, {:forward_agent => true}
default_run_options[:pty] = true


namespace :deploy do
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  desc "Restarting mod_rails (passenger) with tmp/restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Symlink configs
after "deploy:update_code","customs:symlink_database"

namespace(:customs) do
  task :symlink_database, :roles => [:app, :bg] do
    run <<-CMD
      ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml
    CMD
    run <<-CMD
      ln -nfs #{shared_path}/system/secrets.yml #{release_path}/config/secrets.yml
    CMD
  end
end