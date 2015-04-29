require 'bundler/capistrano'

server 'cmuisprojects.org', :web, :app, :db, primary: true

set :application, 'quizzing'
set :user, 'quizzing'
set :group, 'admin'
set :deploy_to, "/home/#{user}/apps/#{application}"

set :scm, 'git'
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :repository, "git@github.com:cmu-is-projects/quizzing.git"
set :branch, 'master'

set :use_sudo, false


# share public/uploads
set :shared_children, shared_children + %w{public/uploads}

# allow password prompt
default_run_options[:pty] = true

# turn on key forwarding
ssh_options[:forward_agent] = true

# keep only the last 5 releases
after 'deploy', 'deploy:cleanup'
after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
    run "ln -s /home/quizzing/apps/quizzing/shared/settings.yml /home/quizzing/apps/quizzing/releases/#{release_name}/config/settings.yml"
    # run "ln -s /home/quizzing/apps/quizzing/shared/settings.yml /home/quizzing/apps/quizzing/releases/#{release_name}/config/"
  end
end

before "deploy:assets:precompile", "deploy:symlink_shared"
after "deploy:symlink_shared", "deploy:migrate"