Gem::Specification.new do |s|
  s.name              = %q{refinerycms-page-images}
  s.version           = %q{2.0.0}
  s.description       = %q{Page Images Engine for Refinery CMS}
  s.date              = %q{2011-08-13}
  s.summary           = %q{Page Images Engine for Refinery CMS}
  s.email             = %q{dave@resolvedigital.com}
  s.homepage          = %q{http://github.com/resolve/refinerycms-page-images}
  s.authors           = ['Resolve Digital', 'David Jones', 'Philip Arndt']
  s.require_paths     = %w(lib)

  s.add_dependency    'refinerycms-pages', '~> 2.0.0'

  s.files             = [
    'app',
    'config',
    'db',
    'lib',
    'readme.md',
    'spec',
    'app/assets',
    'app/assets/javascripts',
    'app/assets/javascripts/page-image-picker.js',
    'app/assets/stylesheets',
    'app/assets/stylesheets/page-image-picker.css.scss',
    'app/models',
    'app/models/refinery',
    'app/models/refinery/image_page.rb',
    'app/views',
    'app/views/refinery',
    'app/views/refinery/admin',
    'app/views/refinery/admin/pages',
    'app/views/refinery/admin/pages/tabs',
    'app/views/refinery/admin/pages/tabs/_images.html.erb',
    'app/views/refinery/admin/pages/tabs/_images_bar.html.erb',
    'app/views/refinery/admin/pages/tabs/_images_field.html.erb',
    'config/locales',
    'config/locales/bg.yml',
    'config/locales/cs.yml',
    'config/locales/de.yml',
    'config/locales/en.yml',
    'config/locales/fr.yml',
    'config/locales/nl.yml',
    'config/locales/pt-BR.yml',
    'config/locales/ru.yml',
    'config/locales/sk.yml',
    'db/migrate',
    'db/migrate/20101014230041_create_page_images.rb',
    'db/migrate/20101014230042_add_caption_to_image_pages.rb',
    'db/migrate/20110511215016_translate_page_image_captions.rb',
    'db/migrate/20110527052435_change_page_to_polymorphic.rb',
    'lib/gemspec.rb',
    'lib/generators',
    'lib/generators/page_images_generator.rb',
    'lib/refinerycms-page-images.rb',
    'spec/models',
    'spec/models/refinery',
    'spec/models/refinery/blog_spec.rb',
    'spec/models/refinery/page_spec.rb',
    'spec/requests',
    'spec/requests/attach_page_images_spec.rb',
    'spec/support',
    'spec/support/refinery',
    'spec/support/refinery/factories.rb'
  ]
end
