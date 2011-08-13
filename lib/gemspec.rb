#!/usr/bin/env ruby
version = '2.0.0'
raise "Could not get version so gemspec can not be built" if version.nil?
files = (Dir.glob("*") | Dir.glob("**/*")).reject{|f| f =~ %r{.gem(spec)?$}}

gemspec = <<EOF
Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{#{version}}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones', 'Philip Arndt']
  s.require_paths     = %w(lib)

  s.add_dependency    'refinerycms-pages', '~> 2.0.0'

  s.files             = [
    '#{files.join("',\n    '")}'
  ]
end
EOF

File.open(File.expand_path("../../refinerycms-page-images.gemspec", __FILE__), 'w').puts(gemspec)