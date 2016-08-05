module Api
  module V1
    class PagesController < ApiController

      def fetch
        page = Page.new url: params[:url]
        if page.valid?
          page.fetch_contents
          if page.save!
            render json: page, root: 'page', adapter: :json
          else
            render json: { errors: 'Cannot fetch page' }
          end
        else
          render json: { errors: page.errors }
        end
      end

      def list
        pages = Page.all
        render json: pages, root: 'pages', adapter: :json
      end
    end
  end
end
