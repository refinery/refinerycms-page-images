Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{0.9.5}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{2010-10-12}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones']
  s.require_paths     = %w(lib)

  #s.add_dependency    'refinerycms', '>= 0.9.9'

  s.files             = [
    'readme.md',
    'app/models',
    'app/models/image_page.rb',
    'app/views',
    'app/views/admin',
    'app/views/admin/pages',
    'app/views/admin/pages/tabs',
    'app/views/admin/pages/tabs/_images.html.erb',
    'lib/gemspec.rb',
    'lib/generators',
    'lib/generators/refinerycms_page_images_generator.rb',
    'lib/refinerycms-page-images.rb',
    'public/javascripts',
    'public/javascripts/page-image-picker.js',
    'public/stylesheets',
    'public/stylesheets/page-image-picker.css'
  ]
  
end
