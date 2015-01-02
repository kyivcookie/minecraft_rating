class FeedsController < ApplicationController
  def show
    @servers = Server.all.limit 20
    render :template => 'feeds/show.rss.builder', :layout => false
  end
end
