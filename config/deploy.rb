# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, "katakana_trainer"
set :scm, :git
set :repo_url, "git@github.com:framgia/katakana_trainer.git"
set :deploy_to, "/usr/local/rails_apps/katakana_trainer"
if ENV["DEPLOY_BRANCH"]                                                         
  set :branch, ENV["DEPLOY_BRANCH"]                                             
else                                                                            
  ask :branch, proc{`git rev-parse --abbrev-ref HEAD`.chomp}.call               
end 
set :pid_file, "#{shared_path}/tmp/pids/unicorn.pid"
set :rvm_type, :system
set :rvm_ruby_version, "2.1.0"                                                  
set :assets_roles, [:web, :app]
set :format, :pretty
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "if test -f #{fetch :pid_file}; then kill -USR2 `cat #{fetch :pid_file}`; fi"
    end
  end
  after :publishing, :restart

end
