module Refinery
  class PageImagesGenerator < Rails::Generators::Base

    def rake_db
      rake("refinery_page_images:install:migrations")
    end

  end
end
