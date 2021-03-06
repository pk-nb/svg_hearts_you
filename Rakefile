#!/usr/bin/env rake

#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../spec/rails/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

require 'rdoc/task'
require 'rspec/core'
require 'rspec/core/rake_task'

# RDoc::Task.new(:rdoc) do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title    = 'SvgHeartsYou'
#   rdoc.options << '--line-numbers'
#   rdoc.rdoc_files.include('README.rdoc')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

Bundler::GemHelper.install_tasks

# Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber, 'Run features that should pass') do |task|
  task.cucumber_opts = '--color --tags ~@wip --strict --format pretty'
end

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare') do |task|
  task.rspec_opts = ['--color']
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r svg_hearts_you.rb"
end

task :default => :spec
task :test => [:spec, :cucumber]
