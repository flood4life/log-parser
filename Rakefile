# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end
desc 'Run tests'

task default: :test
