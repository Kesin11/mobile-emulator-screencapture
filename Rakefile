require "bundler/gem_tasks"
require "rake/testtask"
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

RuboCop::RakeTask.new

task :lint_test do
  Rake::Task['rubocop'].invoke
  Rake::Task['test'].invoke
end

task default: :lint_test
