listen ENV.fetch('PORT', 3000), backlog: Integer(ENV["UNICORN_BACKLOG"] || 16)
timeout ENV["UNICORN_TIMEOUT"] ? Integer(ENV["UNICORN_TIMEOUT"]) : 20
worker_processes ENV["UNICORN_WORKERS"] ? Integer(ENV["UNICORN_WORKERS"]) : 3
preload_app true

before_fork do |server, worker|
  Signal.trap "TERM" do
    puts "Unicorn master intercepting TERM and sending myself QUIT instead"
    Process.kill "QUIT", Process.pid
  end
end

after_fork do |server, worker|
  Signal.trap "TERM" do
    puts "Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT"
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
