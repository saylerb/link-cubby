class Api::V1::ApiBaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
end
