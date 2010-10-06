#!/usr/bin/env ruby
version = '0.9.1'
raise "Could not get version so gemspec can not be built" if version.nil?
files = %w( readme.md )
%w(app config generators lib public rails test vendor).each do |dir|
  files += Dir.glob("#{dir}/**/*") if File.directory?(dir)
end

gemspec = <<EOF
Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{#{version}}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones']
  s.require_paths     = %w(lib)

  #s.add_dependency    'refinerycms', '>= 0.9.9'

  s.files             = [
    '#{files.join("',\n    '")}'
  ]
  #{"s.test_files        = [
    '#{Dir.glob("test/**/*.rb").join("',\n    '")}'
  ]" if File.directory?("test")}
end
EOF

File.open(File.expand_path("../../refinerycms-page-images.gemspec", __FILE__), 'w').puts(gemspec)