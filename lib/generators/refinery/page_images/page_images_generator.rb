module Refinery
  class PageImagesGenerator < ::Rails::Generators::Base

    def rake_db
      rake("refinery_page_images:install:migrations")
    end

    source_root File.expand_path('../templates', __FILE__)

  end
end
