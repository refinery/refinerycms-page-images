# Encoding: UTF-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'refinery/page_images/version'

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = Refinery::PageImages::Version.to_s
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{2011-10-31}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones', 'Philip Arndt']
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency    'refinerycms-pages', '~> 2.0.0'
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.0'
end
