if defined?(Refinery::Blog)
  Refinery::Blog::Admin::PostsController.prepend(
    Module.new do
      def permitted_post_params
        params[:post][:images_attributes]={} if params[:post][:images_attributes].nil?
        super <<  [images_attributes: [:id, :caption, :image_page_id]]
      end
    end
  )
end