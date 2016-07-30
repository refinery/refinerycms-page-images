Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params
      params[:page][:images_attributes]={} if params[:page][:images_attributes].nil?
      super <<  [images_attributes: [:id, :caption, :image_page_id]]
    end
  end
)