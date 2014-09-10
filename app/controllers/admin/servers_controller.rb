class Admin::ServersController < ApplicationController
  before_action :set_admin_server, only: [:show, :edit, :update, :destroy]

  # GET /admin/servers
  # GET /admin/servers.json
  def index
    @admin_servers = Server.paginate :page => params[:page], :per_page => 20
  end

  # GET /admin/servers/1
  # GET /admin/servers/1.json
  def show
  end

  # GET /admin/servers/new
  def new
    @admin_server = Admin::Server.new
  end

  # GET /admin/servers/1/edit
  def edit
  end

  # POST /admin/servers
  # POST /admin/servers.json
  def create
    @admin_server = Admin::Server.new(admin_server_params)

    respond_to do |format|
      if @admin_server.save
        format.html { redirect_to @admin_server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @admin_server }
      else
        format.html { render :new }
        format.json { render json: @admin_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/servers/1
  # PATCH/PUT /admin/servers/1.json
  def update
    respond_to do |format|
      if @admin_server.update(admin_server_params)
        format.html { redirect_to @admin_server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_server }
      else
        format.html { render :edit }
        format.json { render json: @admin_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/servers/1
  # DELETE /admin/servers/1.json
  def destroy
    @admin_server.destroy
    respond_to do |format|
      format.html { redirect_to admin_servers_url, notice: 'Server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_server
      @admin_server = Admin::Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_server_params
      params[:admin_server]
    end
end
