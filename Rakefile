require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

$LOAD_PATH.unshift("lib")
require 'quacks_like'

task :default => ['test']

PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

LIB_DIRECTORIES = FileList.new do |fl|
  fl.include "#{PROJECT_ROOT}/lib"
end
 
TEST_FILES = FileList.new do |fl|
  fl.include "#{PROJECT_ROOT}/test/**/*_test.rb"
end

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
  rd.title = 'QuacksLike Documentation'
end


#Hey, thanks, mislave-will_paginate!
desc %{Update ".manifest" with the latest list of project filenames. Respect\
.gitignore by excluding everything that git ignores. Update `files` and\
`test_files` arrays in "*.gemspec" file if it's present.}
task :manifest do
  list = `git ls-files --full-name --exclude=*.gemspec --exclude=.*`.chomp.split("\n")
  
  if spec_file = Dir['*.gemspec'].first
    spec = File.read spec_file
    spec.gsub! /^(\s* s.(test_)?files \s* = \s* )( \[ [^\]]* \] | %w\( [^)]* \) )/mx do
      assignment = $1
      bunch = $2 ? list.grep(/^test\//) : list
      '%s%%w(%s)' % [assignment, bunch.join(' ')]
    end
      
    File.open(spec_file, 'w') { |f| f << spec }
  end
  File.open('.manifest', 'w') { |f| f << list.join("\n") }
end


# Hey, thanks, thoughtbot-shoulda
spec = Gem::Specification.new do |s|
  s.name = "quacks_like"
  s.version = QuacksLike::VERSION
  s.summary = "Type like a duck."
  s.description = 'QuacksLike is a tiny gem intended to push people towards using duck typing instead of static typing.'
  s.homepage = "http://github.com/gcnovus/quacks_like"

  s.files = FileList["[A-Z]*", "{lib,test}/**/*"]

  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--main", "lib/quacks_like.rb"]

  s.authors = ["James Rosen"]
  s.email = "james.a.rosen@gmail.com"
end
 
Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end
 
desc "Clean files generated by rake tasks"
task :clobber => [:clobber_rdoc, :clobber_package]
 
desc "Generate a gemspec file for GitHub"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
