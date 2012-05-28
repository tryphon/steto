require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/}
end

task :readme do
  require 'RedCloth'
  File.open("README.html","w") do |f|
    f.write RedCloth.new(IO.read("README.textile")).to_html
  end
end
