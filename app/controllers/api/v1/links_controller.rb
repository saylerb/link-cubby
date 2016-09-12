class Api::V1::LinksController < Api::V1::ApiBaseController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { errors: "Must be logged in not logged in" }, status: 422
    end
  end
end
