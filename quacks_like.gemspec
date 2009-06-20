# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{quacks_like}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Rosen"]
  s.date = %q{2009-06-20}
  s.description = %q{QuacksLike is a tiny gem intended to push people towards using duck typing instead of static typing.}
  s.email = %q{james.a.rosen@gmail.com}
  s.files = %w(README.md Rakefile lib/quacks_like.rb test/quacks_like_test.rb)
  s.homepage = %q{http://github.com/gcnovus/quacks_like}
  s.rdoc_options = ["--line-numbers", "--main", "lib/quacks_like.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Type like a duck.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
