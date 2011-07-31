# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Viking::Application.load_tasks

desc 'Run all the tests at once.'
Rake::TestTask.new(:testall) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/functional/**/*_test.rb', 'test/unit/*_test.rb']
  t.verbose = true
end
