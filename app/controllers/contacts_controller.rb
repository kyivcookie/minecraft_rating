class ContactsController < ApplicationController
  #GET
  def show
    @email = ''
    @disabled = false

    unless current_user.nil?
      @email = current_user.email
      @disabled = true
    end
  end

  #POST
  def create
    respond_to do |format|
      if ContactMailer.contact_email(params[:contact][:name],params[:contact][:email],params[:contact][:description]).deliver
        format.html {redirect_to(servers_path, notice:'Your message was been send')}
      end
    end
  end
end
