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

        config.enabled_models.each do |model_class_name|
          unless (model_class = model_class_name.safe_constantize)
            Rails.logger.warn "PageImages is unable to find model class: #{model_class_name}"
            next
          end
          model_class.send :has_many_page_images
        end

        Refinery::Image.send :has_many, :image_pages, :dependent => :destroy

        # dosnt work wothout this...
        require root.join('app/decorators/controllers/refinery/admin/pages_controller_decorator.rb')

      end
    end

    require 'refinery/page_images/engine'
  end
end
