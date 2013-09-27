require 'bundler/capistrano'

set :application, 'bawsaq'
set :repository,  'https://github.com/byroot/bawsaq_history.git'

set :scm, :git
set :deploy_via, :remote_cache

set :use_sudo, false
set :deploy_to, '/home/byroot/www/bawsaq/'

host = 'ssh.alwaysdata.com'

role :web, host
role :app, host
role :db,  host, :primary => true

namespace :file do
  desc "Create symlink for uncommited files"
  task :symlink do
    paths = %w(
      config/database.yml
    )

    paths.each do |path|
      run "rm -rf #{latest_release}/#{path}"
      run "ln -nfs #{shared_path}/#{path} #{latest_release}/#{path}"
    end
  end

end

after 'deploy:update_code', 'file:symlink'
