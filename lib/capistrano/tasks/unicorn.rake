namespace :unicorn do
  task :stop do
    on release_roles(:all) do
      f = "#{release_path}/tmp/pids/unicorn.pid"
      execute <<-CMD
        if [ -a #{f} ]; then\
          kill -s QUIT $(cat #{f})
        else\
          echo 'No pid file found'
        fi
      CMD
    end
  end

  task :start do
    on release_roles(:all) do
      execute "cd #{release_path}; bundle exec unicorn -c config/unicorn.rb -D"
    end
  end

  task :restart

  before :restart, :stop
  after :restart, :start

end


# namespace :unicorn do
#   task :stop do
#     within release_path do
#       pid = File.read("tmp/pids/unicorn.pid").to_i
#       Process.kill :QUIT, pid
#     end
#   end

#   task :start do
#     within release_path do
#       execute "bundle exec unicorn -c config/unicorn.rb -D"
#     end
#   end

#   task :restart

#   before :restart, :stop
#   after :restart, :start

# end
