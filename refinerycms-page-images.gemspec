Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{1.0}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{2011-01-26}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones', 'Philip Arndt']
  s.require_paths     = %w(lib)

  s.add_dependency    'refinerycms', '>= 0.9.9'

  s.files             = [
    'app',
    'db',
    'lib',
    'public',
    'readme.md',
    'app/models',
    'app/models/image_page.rb',
    'app/views',
    'app/views/admin',
    'app/views/admin/pages',
    'app/views/admin/pages/tabs',
    'app/views/admin/pages/tabs/_images.html.erb',
    'app/views/admin/pages/tabs/_images_bar.html.erb',
    'app/views/admin/pages/tabs/_images_field.html.erb',
    'db/migrate',
    'db/migrate/20101014230041_create_page_images.rb',
    'db/migrate/20101014230042_add_caption_to_image_pages.rb',
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
