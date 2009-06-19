require 'rake/testtask'

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