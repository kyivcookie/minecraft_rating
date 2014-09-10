class Admin::SettingsController < ApplicationController
  before_action :set_admin_setting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /admin/settings
  # GET /admin/settings.json
  def index
    @admin_setting =  Settings.all
  end

  # GET /admin/settings/1
  # GET /admin/settings/1.json
  def show
  end

  # GET /admin/settings/new
  def new
    @admin_setting = Settings.new
  end

  # GET /admin/settings/1/edit
  def edit
  end

  # POST /admin/settings
  # POST /admin/settings.json
  def create
    #hardcode
    params[:settings].each do |s|
      setting = Settings.where key: s[0]
      setting = setting[0]
      # setting.value = s[1]
      setting.update value: s[1]
    end
    respond_to do |format|
      format.html {render :index, notice: 'Setting was successfully updated.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_setting
      @admin_setting = Settings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_setting_params
      params[:admin_setting]
    end
end
