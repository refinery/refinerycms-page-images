module Refinery
  autoload :PageImagesGenerator, File.expand_path('../generators/refinery/page_images_generator', __FILE__)

  module PageImages

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end

    require 'refinery/page_images/engine'
    require 'refinery/page_images/extension'
  end
end
