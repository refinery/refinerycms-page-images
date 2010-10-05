require 'refinery'

module Refinery
  module PageImages
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      config.after_initialize do
        <% # need to implement this in Refinery yet %>
        Refinery::Pages.register_tab do |tab|
          tab.name = "images"
          tab.template = "/admin/pages/tabs/images"
        end
        
      end
    end
  end
end

