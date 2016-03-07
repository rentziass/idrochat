class Api::V1::UsersController < ApplicationController
  def search
    users = User.search params[:q], limit: 5
    html = ""
    users.each do |user|
      html << ApplicationController.renderer.render(
        partial: "users/user_search",
        locals: { user: user },
        misspellings: { below: 1, edit_distance: 4 },
      )
    end
    render json: { html: html }, root: false, status: 200
  end
end
