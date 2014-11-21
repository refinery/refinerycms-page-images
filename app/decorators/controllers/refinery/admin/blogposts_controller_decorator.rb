if defined?(Refinery::Blog)
  Refinery::Blog::Admin::PostsController.class_eval do

    # work around an issue with stack level too deep, due to an issue with decorators.
    if self.instance_methods.exclude?(:post_params_with_page_image_params)
      # We need to add :images_attributes to post_params as it is ignored by strong parameters. (See #100)
      def post_params_with_page_image_params

        # Get the :images_attributes hash from params
        page_image_params = params.require(:post).permit(images_attributes: [:id, :caption])

        # If there is no :images_attributes hash use a blank hash (so it removes deleted images)
        page_image_params = {images_attributes:{}} if page_image_params[:images_attributes].nil?

        # Add the :images_attributes hash to the default post_params hash
        post_params_without_page_image_params.merge(page_image_params)

      end

      # Swap out the default post_params method with our new one
      alias_method_chain :post_params, :page_image_params
    end
  end
end