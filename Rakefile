require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rdoc/task'

RSpec::Core::RakeTask.new

RDoc::Task.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end

task :default => :spec
task :test => :spec
