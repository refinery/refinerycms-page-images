module Refinery
  class PageImagesGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def rake_db
      rake("refinery_page_images:install:migrations")
    end

    def generate_page_images_initializer
      template "config/initializers/refinery/page_images.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "page_images.rb")
    end

  end
end
