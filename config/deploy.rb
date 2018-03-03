require 'mina/rails'
require 'mina/git'

require 'mina/git'
require 'mina/rbenv'
require 'mina/bundler'

set :application_name, 'github_file_explorer'
set :domain,           'ec2-52-43-90-248.us-west-2.compute.amazonaws.com'
set :deploy_to,        '/home/ec2-user/github_file_explorer'
set :repository,       'https://github.com/fangnan124/github_file_explorer.git'
set :branch,           'master'
set :keep_releases,    5
set :rails_env,        'production'

set :user,             'ec2-user'
set :identity_file,    '/Users/fangnan/Documents/AWS/hou_nan.pem'

set :shared_dirs, fetch(:shared_dirs, []).push(
    'log',
    'tmp'
)
set :shared_files, fetch(:shared_files, []).push(
    'config/database.yml',
    'config/secrets.yml',
    'config/puma.rb'
)

task :environment do
  invoke :'rbenv:load'
end

task :setup do
  # command %{rbenv install 2.3.0}
end

desc "Deploys the current version to the server."
task :deploy do

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        # command %{mkdir -p tmp/}
        # command %{touch tmp/restart.txt}
        invoke :'puma:restart'
      end
    end
  end

end

namespace :puma do
  task :start do
    in_path(fetch(:current_path)) do
      command %{bundle exec pumactl -F config/puma.rb start}
    end
  end

  task :stop do
    in_path(fetch(:current_path)) do
      command %{bundle exec pumactl -F config/puma.rb stop}
    end
  end

  task :restart do
    in_path(fetch(:current_path)) do
      # command %{touch tmp/restart.txt}
      command %{bundle exec pumactl -F config/puma.rb restart}
    end
  end
end
