class Api::V1::LinksController < Api::V1::ApiBaseController
  def index
    if current_user
      if params[:by] || params[:sort]
        render json: Link.sort_by_params(current_user, params[:by], params[:sort])
      else
        render json: current_user.links
      end
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
        render json: link.errors.full_messages, status: 422
      end
    else
      render json: { errors: "Must be logged in" }, status: 422
    end
  end

  def update
    original_link = Link.find(params[:id])

    updated_link = Link.update(params[:id], link_params)
    if updated_link.valid?
      render json: updated_link, status: 200
    else
      render json: { errors: updated_link.errors.full_messages.join(", "), link: original_link }, status: 422
    end
  end

  def destroy
    Link.find(params[:id]).destroy
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
