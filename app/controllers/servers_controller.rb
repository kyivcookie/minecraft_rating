# require 'minecraft-query'
class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy, :vote]
  before_action :authenticate_user!, only: [:new, :edit, :update, :my_servers, :vote]
  # before_action :banner do
  #   layout false
  #   layout 'application', :except => :view
  # end

  # helper :servers

  # GET /servers
  # GET /servers.json
  def index
    time = Time.now - 30.days
    @page = 1
    @servers = Server.where(:vip => 0).order('votes DESC').paginate :page => params[:page], :per_page => 20
    if params[:page]
      @page = params[:page].to_i
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
  end

  # GET /servers/1/banner
  def banner
    @server = Server.find(params[:id])
    send_file @server.banner.file.file, :disposition => 'inline'
  end

  def my_servers
    @page = 1
    @servers = Server.where(:user_id => current_user.id).paginate :page => params[:page], :per_page => 20
    if params[:page]
      @page = params[:page].to_i
    end
  end

  def vote
    #todo why cache don't work fine?
    @server.increment! :votes
    current_user.update(voted_at: Time.now.to_i)
    sleep(3)
    render js: %(window.location.href='#{server_url(@server)}') and return
  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
  end

  def check
    ip = params[:cost]
    vars = MinecraftPing.new(params[:cost]).check_protocol

    respond_to do |format|
      format.json {render json: vars}
    end
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(server_params)
    @server.user_id = current_user.id
    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit(:user_id, :category_id, :ip, :vip, :port, :banner, :name, :country, :description, :website, :youtube_id, :votes, :disabled, :status, :votifier_key, :votifier_ip, :votifier_port, :players, :max_players, :server_version, :cache_time, :protocol)
    end
end
