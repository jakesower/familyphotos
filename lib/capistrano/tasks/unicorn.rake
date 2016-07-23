namespace :unicorn do
  desc 'Stop Unicorn'
  task :stop do
    if test("[ -f #{fetch(:unicorn_pid)} ]")
      execute :kill, capture(:cat, fetch(:unicorn_pid))
    end
  end

  desc 'Start Unicorn'
  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, "exec unicorn -c #{fetch(:unicorn_config)} -D"
      end
    end
  end

  desc 'Reload Unicorn without killing master process'
  task :reload do
    on roles(:app) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, '-s USR2', capture(:cat, fetch(:unicorn_pid))
      else
        error 'Unicorn process not running'
      end
    end
  end

  desc 'Restart Unicorn'
  task :restart
  before :restart, :stop
  before :restart, :start
end