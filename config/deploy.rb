# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2-p290@rails31'
set :rvm_type, :user  # Don't use system-wide RVM


default_run_options[:pty] = true

set :application, "viking"
set :repository,  "git@github.com:rebelcolony/viking.git"
set :rails_env, "production"

set :scm, :git
set :deploy_via, :remote_cache

set :server_domain, "72.14.189.134"
set :app_domain, "http://www.vikingpizza.no"

role :web, server_domain                          # Your HTTP server, Apache/etc
role :app, server_domain                        # This may be the same as your `Web` server
role :db,  server_domain, :primary => true # This is where Rails migrations will run


set :deploy_to, "/var/www/apps/#{application}"
set :user, "rebel"
set :runner, user

ssh_options[:keys] = %w(/Users/alastairbrunton/.ssh/ndthub /Users/rebel/.ssh/id_rsa)
ssh_options[:port] = 8888

# monit config
#set :monit_from_address, 'monit@xxx'
#set :monit_alert_address, 'alastair@simplyexcited.co.uk'

# Restart passenger task.

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Hooks

after "deploy:update_code", "recipiez:rename_db_file"
after "deploy:restart", "deploy:cleanup"

task :change_owner do
  run "chown -R rebel:rebel #{release_path}"
end


set :bundle_dir, "#{shared_path}/bundle"
require "bundler/capistrano"

