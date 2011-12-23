require 'refinerycms-core'

module Refinery
  autoload :PageImagesGenerator, 'generators/refinery/page_images_generator'

  module PageImages

    require 'refinery/page_images/engine' if defined?(Rails)
    require 'refinery/page_images/has_many_page_images'

    autoload :Version, 'refinery/page_images/version'

    def self.root
      @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
    end

    def self.version
      ::Refinery::PageImages::Version.to_s
    end

    def self.factory_paths
      @factory_paths ||= [root.join("spec/factories").to_s]
    end
  end
end

ActiveRecord::Base.extend Refinery::PageImages::HasManyPageImages
