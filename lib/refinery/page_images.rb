require 'refinerycms-core'

module Refinery
  autoload :PageImagesGenerator, 'generators/refinery/page_images_generator'

  module PageImages

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end

      def attach!
        require 'refinery/page'
        require 'refinery/page_images/extension'
        Refinery::Page.send :has_many_page_images
        Refinery::Blog::Post.send :has_many_page_images if defined?(::Refinery::Blog)
        Refinery::Image.send :has_many, :image_pages, :dependent => :destroy
      end
    end

    require 'refinery/page_images/engine'
  end
end
