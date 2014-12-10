class SearchController < ApplicationController
  def show
    @result = []

    if params[:search] && params[:search][:q]
      @result = Server.where("name LIKE '%#{params[:search][:q]}%'").take(20)
    end
  end
end
