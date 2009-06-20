require 'rake/testtask'
require 'rake/rdoctask'

task :default => ['test']

PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

LIB_DIRECTORIES = FileList.new do |fl|
  fl.include "#{PROJECT_ROOT}/lib"
end
 
TEST_FILES = FileList.new do |fl|
  fl.include "#{PROJECT_ROOT}/test/**/*_test.rb"
end

$: << File.join(PROJECT_ROOT, 'lib')

desc 'Run all tests'
Rake::TestTask.new(:test) do |t|
  t.libs        = LIB_DIRECTORIES
  t.test_files  = TEST_FILES
  t.verbose     = true
end

desc "Build a code coverage report"
task :coverage do
  files = TEST_FILES.join(" ")
  sh "rcov -o coverage #{files} --exclude ^/Library/Ruby/,^init.rb --include lib/ --include-file ^lib/.*\\.rb"
end

namespace :coverage do
  task :clean do
    rm_r 'coverage' if File.directory?('coverage')
  end
end

Rake::RDocTask.new(:rdoc) do |rd|
  rd.rdoc_dir = 'doc'
  rd.main = 'lib/quacks_like.rb'
  rd.rdoc_files.include("lib/**/*.rb")
  rd.options << "--all"
end
