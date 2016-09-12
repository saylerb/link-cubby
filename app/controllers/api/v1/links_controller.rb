class Api::V1::LinksController < Api::V1::ApiBaseController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { errors: "Must be logged in" }, status: 422
    end
  end

  def create
    if current_user
      link = Link.new(link_params)
      current_user.links << link

      if link.save
        render json: link, status: 201
      else
        render json: link.errors.full_messages.join(", "), status: 422
      end
    else
      render json: { errors: "Must be logged in" }, status: 422
    end
  end

  def update
    link = Link.update(params[:id], link_params)
    render json: link, status: 200
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
