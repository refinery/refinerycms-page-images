Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{2.0.0}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Philip Arndt', 'David Jones']
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency    'refinerycms-pages', '~> 2.0.0'
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.0'
end
