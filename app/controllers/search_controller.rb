class SearchController < ApplicationController
  def show
    if params[:search] && params[:search][:q]
      @result = Server.where("name LIKE '%#{params[:search][:q]}%'")
    end
  end
end
