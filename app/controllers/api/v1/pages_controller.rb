module Api
  module V1
    class PagesController < ApiController

      def fetch
        page = Page.new url: params[:url]
        if page.valid?
          render json: { contents: 'Rathanak'}
        else
          render json: { errors: page.errors }
        end
      end

      def list
        contents = Page.all
        render json: contents#{ contents: contents}
      end
    end
  end
end
